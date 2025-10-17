/*
*/


#include<vector>
#include<iostream>
#include<type_traits>
#include <unordered_set>
#include <unordered_map>
#include <functional>
#include <algorithm>
#include"ncbind.hpp"
#include"kim/KimException.h"


#define PUZZLE_NODE_MAX_COUNT	1000

/**/
namespace bm88 {
	namespace details {

		/**/
		struct PuzzlePiece
		{
			tjs_int type;
			tjs_int x;
			tjs_int y;
		};

		/**/
		struct PuzzleBlock
		{
			PuzzlePiece piece1;		// 回転側
			PuzzlePiece piece2;		// 回転軸
		};

		/**/
		enum class PuzzleDirection
		{
			DIR_UP,
			DIR_DOWN,
			DIR_LEFT,
			DIR_RIGHT
		};

		/**/
		struct PuzzleNode
		{
			typedef PuzzleNode* pointer_type;

			PuzzleBlock block;
			PuzzleDirection dir;
			tjs_int value;
			tjs_int myValue;
			tjs_int chain;
			tjs_int fire;
			pointer_type pParent;
			pointer_type first_child;    // 最初の子供を指す
			pointer_type next_sibling;   // 次の兄弟を指す
			tjs_int map[1];
		};

		/*
		* アロケータ
		*/
		class PuzzleAllocator
		{
		private:
			struct FreeNode
			{
				FreeNode* next;
			};

		public:
			PuzzleAllocator() :
				m_Pool(nullptr),
				m_BlockSize(0),
				m_BlockCount(0),
				m_FreeList(nullptr)
			{
			};
			// コピーコンストラクタとコピー代入演算子を削除
			PuzzleAllocator(const PuzzleAllocator&) = delete;
			PuzzleAllocator& operator=(const PuzzleAllocator&) = delete;

			virtual ~PuzzleAllocator()
			{
				FreePool();
			};

			void SetBlockSizeAndCount(const tjs_int size, const tjs_int count)
			{
				m_BlockSize = size;
				m_BlockCount = count;

				Initialize();
			};

			const tjs_int GetBlockSize() const
			{
				return m_BlockSize;
			};

			void* Allocate()
			{
				if (!m_FreeList) {
					return nullptr;
				}

				void* block = m_FreeList;
				m_FreeList = m_FreeList->next;
				return block;
			};

			void Deallocate(void* ptr)
			{
				if (!HasPointer(ptr))
				{
					return;
				}

				FreeNode* node = static_cast<FreeNode*>(ptr);
				node->next = m_FreeList;
				m_FreeList = node;
			};

			bool HasPointer(void* ptr)
			{
				char* pStart = static_cast<char*>(m_Pool);
				char* pEnd = pStart + (m_BlockSize * m_BlockCount);

				return (ptr >= pStart && ptr < pEnd);
			};

		private:
			void Initialize()
			{
				FreePool();

				// アラインメントを構造体に合わせる
				std::size_t alignment = alignof(PuzzleNode);
				m_Pool = _aligned_malloc(m_BlockSize * m_BlockCount, alignment);

				if (!m_Pool)
				{
					throw std::bad_alloc();
				}

				m_FreeList = nullptr;

				for (tjs_int i = 0; i < m_BlockCount; ++i) {
					void* block = static_cast<char*>(m_Pool) + i * m_BlockSize;
					FreeNode* node = static_cast<FreeNode*>(block);
					node->next = m_FreeList;
					m_FreeList = node;
				}
			};

			void FreePool()
			{
				if (m_Pool)
				{
					_aligned_free(m_Pool);
					m_Pool = nullptr;
				}
			}

		public:
			void* m_Pool;
			tjs_int m_BlockSize;
			tjs_int m_BlockCount;
			FreeNode* m_FreeList;
		};
	}
}

/**/
class PuzzleAICore
{
public:
	class Pos
	{
	public:
		Pos() :
			m_x(0), m_y(0)
		{
		};
		Pos(const tjs_int x, const tjs_int y) :
			m_x(x), m_y(y)
		{
		};
		Pos(const Pos& pos) :
			m_x(pos.m_x), m_y(pos.m_y)
		{
		};
		virtual ~Pos()
		{
		};

	public:
		tjs_int m_x;
		tjs_int m_y;
	};

	typedef bm88::details::PuzzleAllocator	allocator_type;
	typedef bm88::details::PuzzleNode		node_type;

	typedef std::vector<tjs_int>			map_type;
	typedef std::vector<tjs_int>			vector_type;
	typedef std::vector<Pos>				pos_type;

	typedef std::vector<allocator_type*>	allocators;

private:
	// マップの状態をハッシュ値に変換する関数オブジェクト
	struct MapHasher {
		std::size_t operator()(const std::vector<tjs_int>& map) const {
			std::size_t hash = map.size();
			for (const auto& i : map) {
				hash ^= i + 0x9e3779b9 + (hash << 6) + (hash >> 2);
			}
			return hash;
		}
	};

public:
	/**/
	PuzzleAICore() :
		m_Alloc(),
		m_EntryX(0), m_EntryY(0),
		m_Width(0), m_Height(0),
		m_SizeOfNode(0),
		m_MapSize(0),
		m_Level(0), m_MaxChain(0), m_Linking(0),
		m_Root(nullptr),
		m_Debug(0)
	{
	};
	/**/
	virtual ~PuzzleAICore()
	{
		// デストラクタで確保したアロケータを全て解放する
		FreeAllocators();
	};

	/**/
	void SetEntryPoint(const tjs_int entryX, const tjs_int entryY)
	{
		m_EntryX = entryX;
		m_EntryY = entryY;
	}

	/**/
	void SetLevel(const tjs_int level)
	{
		m_Level = level;

		switch (level)
		{
		case 0:
			m_MaxChain = 1;
			break;
		case 1:
			m_MaxChain = 2;
			break;
		case 2:
			m_MaxChain = 3;
			break;
		case 3:
			m_MaxChain = 4;
			break;
		case 4:
			m_MaxChain = 5;
			break;
		default:
			TVPThrowExceptionMessage(TJS_W("有効なAIレベルは0～4の範囲です。"));
			break;
		}
	};
	/**/
	tjs_int GetLevel() const
	{
		return m_Level;
	};
	/**/
	void SetLinking(const tjs_int linking)
	{
		if (linking <= 1)
		{
			TVPThrowExceptionMessage(TJS_W("SetLinking()に指定できる数は2以上です。"));
		}

		m_Linking = linking;
	};
	/**/
	tjs_int GetLinking() const
	{
		return m_Linking;
	};

	/**/
	void SetMapSize(const tjs_int width, const tjs_int height)
	{
		m_Width = width;
		m_Height = height;
		m_MapSize = sizeof(tjs_int) * width * height;
		m_SizeOfNode = sizeof(node_type) + m_MapSize - sizeof(tjs_int);

		FreeAllocators();

		// ルートを作る
		m_Root = AllocNode();
	};
	/**/
	void AddOjamaType(const tjs_int type)
	{
		m_OjamaTypes.push_back(type);
	};
	/**/
	void SetOjamaPieces(iTJSDispatch2* mapArray)
	{
		// 引数が有効なTJS2オブジェクトかチェック
		if (!mapArray) {
			TVPThrowExceptionMessage(TJS_W("引数は有効なTJS2の配列である必要があります。"));
		}

		// 配列のサイズを取得
		tjs_int arraySize = 0;
		tTJSVariant arraySizeV(arraySize);
		if (TJS_FAILED(mapArray->PropGet(TJS_MEMBERENSURE, TJS_W("count"), nullptr, &arraySizeV, mapArray))) {
			TVPThrowExceptionMessage(TJS_W("TJS2の配列のサイズを取得できませんでした。"));
		}
		arraySize = arraySizeV;

		// 辞書配列の配列を走査し、x, y, idを取得してマップに設定
		for (tjs_int i = 0; i < arraySize; i++) {
			tTJSVariant element;
			std::wstring index = std::to_wstring(i);
			if (TJS_FAILED(mapArray->PropGet(TJS_MEMBERENSURE, index.c_str(), nullptr, &element, mapArray))) {
				continue; // 取得に失敗したらスキップ
			}

			if (element.Type() != tvtObject) {
				TVPThrowExceptionMessage(TJS_W("配列の要素は辞書オブジェクトである必要があります。"));
			}

			iTJSDispatch2* dictObj = element.AsObjectNoAddRef();
			if (!dictObj) {
				continue; // オブジェクトが取得できなければスキップ
			}

			tjs_int x = 0, y = 0, type = 0;
			tTJSVariant v_x, v_y, v_type;

			// 'x' プロパティを取得
			if (TJS_SUCCEEDED(dictObj->PropGet(TJS_MEMBERENSURE, TJS_W("gridX"), nullptr, &v_x, dictObj)) && v_x.Type() == tvtInteger) {
				x = (tjs_int)v_x;
			}
			// 'y' プロパティを取得
			if (TJS_SUCCEEDED(dictObj->PropGet(TJS_MEMBERENSURE, TJS_W("gridY"), nullptr, &v_y, dictObj)) && v_y.Type() == tvtInteger) {
				y = (tjs_int)v_y;
			}
			// 'id' プロパティを取得
			if (TJS_SUCCEEDED(dictObj->PropGet(TJS_MEMBERENSURE, TJS_W("id"), nullptr, &v_type, dictObj)) && v_type.Type() == tvtInteger) {
				type = (tjs_int)v_type;
			}

			// 取得した座標が有効かチェックし、マップにおじゃまぷよとして配置
			if (IsValidPos(x, y)) {
				m_Root->map[y * m_Width + x] = type;
			}
		}
	}

	/*
	* piece1:回転軸
	* piece2:回転側
	*/
	void AddNextBlock(const tjs_int piece1, const tjs_int piece2)
	{
		NextStep(m_Root, piece1, piece2);
	};

	/**/
	tTJSVariant GetNextBlock()
	{
		node_type::pointer_type next = GetNextBlockFromList(m_Root);

		if (next == nullptr)
		{
			TVPThrowExceptionMessage(TJS_W("GetNextBlockFromList()がNULLを返しました。"));
		}

		tTJSVariant dictionary;

		TVPExecuteExpression(TJS_W("%[]"), &dictionary);

		// Dictionary オブジェクトを取得
		iTJSDispatch2* dictObj = dictionary.AsObjectNoAddRef();
		tTJSVariant value(next->block.piece2.x);

		dictObj->PropSet(TJS_MEMBERENSURE, TJS_W("x1"), nullptr, &value, dictObj);
		value = next->block.piece2.y;
		dictObj->PropSet(TJS_MEMBERENSURE, TJS_W("y1"), nullptr, &value, dictObj);
		value = next->block.piece2.type;
		dictObj->PropSet(TJS_MEMBERENSURE, TJS_W("type1"), nullptr, &value, dictObj);

		value = next->block.piece1.x;
		dictObj->PropSet(TJS_MEMBERENSURE, TJS_W("x2"), nullptr, &value, dictObj);
		value = next->block.piece1.y;
		dictObj->PropSet(TJS_MEMBERENSURE, TJS_W("y2"), nullptr, &value, dictObj);
		value = next->block.piece1.type;
		dictObj->PropSet(TJS_MEMBERENSURE, TJS_W("type2"), nullptr, &value, dictObj);

		value = static_cast<tjs_int>(next->dir);
		dictObj->PropSet(TJS_MEMBERENSURE, TJS_W("dir"), nullptr, &value, dictObj);
		
		return tTJSVariant(dictObj, dictObj);
	};
	/*
	* 最も価値の高い子ノードを新しいルートとして設定し、他のノードを削除する
	*/
	void SetNextRoot()
	{
		if (!m_Root || !m_Root->first_child) {
			return; // ルートまたは子ノードがない場合は何もしない
		}

		// 最も価値の高い子ノードを特定する
		node_type::pointer_type best_child = GetNextBlockFromList(m_Root);
		if (!best_child) {
			return; // 最適な子ノードが見つからない場合は何もしない
		}

		// 最初に、新しいルートとなるノードを親（m_Root）から切り離す
		node_type::pointer_type current = m_Root->first_child;
		node_type::pointer_type prev = nullptr;
		while (current) {
			if (current == best_child) {
				// best_child をリストから外す
				if (prev) {
					prev->next_sibling = current->next_sibling;
				}
				else {
					m_Root->first_child = current->next_sibling;
				}
				break;
			}
			prev = current;
			current = current->next_sibling;
		}

		// 新しいルートの兄弟ノードを含む、元のルートのすべての子孫を削除する
		DeleteNodeIterative(m_Root);

		// 新しいルートを設定する
		m_Root = best_child;
		m_Root->pParent = nullptr;
		m_Root->next_sibling = nullptr;
	}
	/*
	* ルートノードを残して、子ノードとすべての子孫を削除する
	*/
	void Clear()
	{
		if (!m_Root) {
			return; // ルートノードが存在しない場合は何もしない
		}

		// ルートノードの最初の子を根とするツリー全体を削除する
		node_type::pointer_type child = m_Root->first_child;
		while (child) {
			// 次の兄弟ノードへのポインタを一時的に保存
			node_type::pointer_type next_sibling = child->next_sibling;

			// 現在の子ノードと、そのすべての子孫を削除する
			DeleteNodeIterative(child);

			// 次の兄弟ノードへ進む
			child = next_sibling;
		}

		// ルートノードの first_child ポインタを nullptr に設定してツリーをクリアする
		m_Root->first_child = nullptr;
	}
	/*
	* ルートノードのmapや関連情報を初期化する
	*/
	void InitializeRootNode()
	{
		// ルートノードが存在しない場合は、まず作成する
		if (!m_Root) {
			m_Root = AllocNode();
		}

		// ルートノードの盤面をゼロで初期化
		::memset(m_Root->map, 0, m_MapSize);

		// 評価値や連鎖数などを初期値にリセット
		m_Root->value = 0;
		m_Root->myValue = 0;
		m_Root->chain = 0;
		m_Root->fire = 0;

		// 既存の子ノードがあればすべて削除する
		Clear();
	}

	/**/
	void SetDebugMode(tjs_int bDebug)
	{
		m_Debug = bDebug;
	}

	/**/
	void DumpRootMap()
	{
		DumpNodeMap(m_Root);
	}

	/**
	 * ルートノードのマップ状態をTJS2の二次元配列（配列の配列）として返す
	 */
	tTJSVariant GetRootMap()
	{
		// ルートノードが存在しない場合はNULLを返すか、空の配列を返す
		if (!m_Root) {
			// TJSではnullを返す
			return tTJSVariant(nullptr, nullptr);
		}

		// TJS2の配列オブジェクト（外側の配列）を作成
		tTJSVariant mapArrayV;
		TVPExecuteExpression(TJS_W("[]"), &mapArrayV);
		iTJSDispatch2* mapArray = mapArrayV.AsObjectNoAddRef();
		if (!mapArray) {
			TVPThrowExceptionMessage(TJS_W("TJS2の配列オブジェクトの作成に失敗しました。"));
		}

		// TJS配列は自動的に参照カウントが増加するため、ここではAddRef不要

		for (tjs_int y = 0; y < m_Height; y++)
		{
			// TJS2の配列オブジェクト（内側の配列、行）を作成
			tTJSVariant rowArrayV;
			TVPExecuteExpression(TJS_W("[]"), &rowArrayV);
			iTJSDispatch2* rowArray = rowArrayV.AsObjectNoAddRef();
			if (!rowArray) {
				TVPThrowExceptionMessage(TJS_W("TJS2の内部配列オブジェクトの作成に失敗しました。"));
			}

			for (tjs_int x = 0; x < m_Width; x++)
			{
				// マップの値を取得
				tjs_int value = m_Root->map[y * m_Width + x];

				// 内側の配列に行の要素（ぷよのタイプ）を設定
				tTJSVariant tjsValue(value);
				std::wstring index = std::to_wstring(x);
				rowArray->PropSet(TJS_MEMBERENSURE, index.c_str(), nullptr, &tjsValue, rowArray);
			}

			// 外側の配列に行の配列を設定
			tTJSVariant tjsRow(rowArray, rowArray); // DispatchをVariantでラップ
			std::wstring index = std::to_wstring(y);
			mapArray->PropSet(TJS_MEMBERENSURE, index.c_str(), nullptr, &tjsRow, mapArray);

			// rowArrayはtjsRowとして保持されるため、ここで解放処理は不要
			// TJSの参照カウント機構により管理されます。
		}

		// 最終的なVariantを返す
		return mapArrayV;
	};

private:
	/*
	* 追加したアロケータを返す
	*/
	allocator_type* AddAllocator()
	{
		// 新しいアロケータを動的に確保
		allocator_type* new_alloc = new allocator_type();
		new_alloc->SetBlockSizeAndCount(m_SizeOfNode, PUZZLE_NODE_MAX_COUNT);
		m_Alloc.push_back(new_alloc);

		return new_alloc;
	};
	/**/
	void FreeAllocators()
	{
		// vector内の各ポインタを削除
		for (auto alloc : m_Alloc)
		{
			delete alloc;
		}
		// vectorをクリア
		m_Alloc.clear();
	};

	/**/
	node_type* AllocNode()
	{
		void* raw = nullptr;
		allocator_type* target_alloc = nullptr;

		// 既存のアロケータを順に試す
		for (auto alloc : m_Alloc)
		{
			raw = alloc->Allocate();
			if (raw != nullptr)
			{
				target_alloc = alloc;
				break;
			}
		}

		// 既存のアロケータで確保できなかった場合
		if (raw == nullptr)
		{
			target_alloc = AddAllocator();
			raw = target_alloc->Allocate();

			if (raw == nullptr)
			{
				// これでも確保できない場合は例外
				TVPThrowExceptionMessage(TJS_W("AIの計算領域のメモリ確保に失敗しました。"));
			}
		}

		::memset(raw, 0, m_SizeOfNode);

		// rawがnullptrではないことを確認してからnewを行う
		// これで安全にオブジェクトを構築できる
		node_type* p = new(raw) node_type();

		return p;
	}

	/*
	* 座標が有効かチェック
	*/
	bool IsValidPos(const tjs_int x, const tjs_int y) const
	{
		if (x < 0 || x >= m_Width)
		{
			return false;
		}
		if (y < 0 || y >= m_Height)
		{
			return false;
		}

		return true;
	}

	/**/
	bool IsOjamaPiece(const tjs_int id)
	{
		if (std::find(m_OjamaTypes.begin(), m_OjamaTypes.end(), id) != m_OjamaTypes.end()) {
			return true;
		}

		return false;
	};

	/**/
	bool IsNormalPiece(const tjs_int id)
	{
		if (!IsOjamaPiece(id) && id != 0)
		{
			return true;
		}

		return false;
	};

	/*
	* 出現ポイントの列が危険域に達しているかチェックする
	*/
	bool IsDangerState(node_type* node) const
	{
		// Y=3 (上から4行目) の位置をチェックする。
		// Y=0 は見えない位置、Y=3 は実質的な最上段とする。
		// EntryY (通常は0か1) よりも上の位置、ここではY=3を危険ラインとする。
		const tjs_int danger_y = 3;

		if (!IsValidPos(m_EntryX, danger_y)) {
			// 通常は発生しないが、座標が不正なら安全と見なす
			return false;
		}

		// エントリーX座標の Y=3 の位置にピースがあれば危険
		tjs_int address = danger_y * m_Width + m_EntryX;
		return (node->map[address] != 0);
	}

	/*
	* 次の手を計算する
	*/
	void NextStep(node_type* root, const tjs_int piece1, const tjs_int piece2)
	{
		if (root == nullptr) {
			return;
		}

		std::vector<node_type::pointer_type> stack;
		stack.push_back(root);

		while (!stack.empty()) {
			node_type::pointer_type current = stack.back();
			stack.pop_back();

			// 子ノードがない場合（葉ノード）に処理を行う
			if (current->first_child == nullptr) {
				CalcNextStep(current, piece1, piece2);
			}
			else {
				// 子ノードがある場合、すべての子ノードをスタックにプッシュ
				node_type::pointer_type child = current->first_child;
				while (child != nullptr) {
					stack.push_back(child);
					child = child->next_sibling;
				}
			}
		}
	}
	/**/
	void CalcNextStep(node_type* current, const tjs_int piece1, const tjs_int piece2)
	{
		bm88::details::PuzzleDirection dirs[] = {
			bm88::details::PuzzleDirection::DIR_UP,
			bm88::details::PuzzleDirection::DIR_DOWN,
			bm88::details::PuzzleDirection::DIR_LEFT,
			bm88::details::PuzzleDirection::DIR_RIGHT
		};

		if (current == nullptr)
		{
			return;
		}

		// 配置可能な X 座標の範囲を決定する
		tjs_int start_x = 0;
		tjs_int end_x = m_Width - 1;

		// 左側（m_EntryX から左）のチェック
		// m_EntryX より左側の列をチェックし、Y=1 まで積み上がっている列を探す
		for (tjs_int x = m_EntryX - 1; x >= 0; x--)
		{
			// Y=1 (最上段) のセルが埋まっているかチェック
			if (current->map[1 * m_Width + x] != 0)
			{
				// Y=1 まで積み上がっている場合、その列とそれより左側は配置不可
				// したがって、配置可能な左端を x の右隣 (x + 1) に設定
				start_x = x + 1;
				break;
			}
		}

		// 右側（m_EntryX から右）のチェック
		// m_EntryX より右側の列をチェックし、Y=1 まで積み上がっている列を探す
		for (tjs_int x = m_EntryX + 1; x < m_Width; x++)
		{
			// Y=1 (最上段) のセルが埋まっているかチェック
			if (current->map[1 * m_Width + x] != 0)
			{
				// Y=1 まで積み上がっている場合、その列とそれより右側は配置不可
				// したがって、配置可能な右端を x の左隣 (x - 1) に設定
				end_x = x - 1;
				break;
			}
		}

//		std::cout << "begin CalcNextStep() function" << std::endl;

		for (tjs_int i = 0; i < KIM_ARRAY_COUNT(dirs); i++)
		{
			// まずは回転軸の位置を決定する
			for (tjs_int x = start_x; x <= end_x; x++)
			{
				// xが0または最大値の場合、向きによっては配置できない
				if ((x == 0 && dirs[i] == bm88::details::PuzzleDirection::DIR_LEFT) ||
					(x == (m_Width - 1) && dirs[i] == bm88::details::PuzzleDirection::DIR_RIGHT))
				{
					continue;
				}

				// y位置を決定する
				tjs_int y = 0;
				for (y = m_Height - 1; y >= 1; y--)
				{
					if (current->map[y * m_Width + x] == 0)
					{
						break;
					}
				}

				// DIR_DOWNの時はyを一個上にずらす
				if (dirs[i] == bm88::details::PuzzleDirection::DIR_DOWN)
				{
					y--;
					if (y < 1)
					{
						continue;
					}
				}

				// yが最大値の場合、向きによっては配置できない
				// yが0以下の場合配置できない
				if (y <= 0 || ((y == m_Height - 1) && dirs[i] == bm88::details::PuzzleDirection::DIR_DOWN))
				{
					continue;
				}

				// 回転軸位置を決定する
				tjs_int x2 = x;
				tjs_int y2 = y;

				switch (dirs[i])
				{
				case bm88::details::PuzzleDirection::DIR_UP:
					y2 -= 1;
					break;
				case bm88::details::PuzzleDirection::DIR_DOWN:
					y2 += 1;
					break;
				case bm88::details::PuzzleDirection::DIR_LEFT:
					x2 -= 1;
					break;
				case bm88::details::PuzzleDirection::DIR_RIGHT:
					x2 += 1;
					break;
				}
				if (current->map[y2 * m_Width + x2] == 0)
				{
					// 下へ
					while (y2 < m_Height - 1 && current->map[(y2 + 1) * m_Width + x2] == 0)
					{
						// (x, y) == (x2, y2 + 1)の場合、そこには今回発生したピースが配置される予定なので抜ける
						if (x2 == x && (y2 + 1) == y)
						{
							break;
						}
						y2++;
					}
				}
				else
				{
					// 上へ
					while (y2 > 0 && current->map[y2 * m_Width + x2] != 0)
					{
						y2--;
					}
				}

				if (y2 <= 0)
				{
					continue;
				}

				tjs_int address1 = y * m_Width + x;
				tjs_int address2 = y2 * m_Width + x2;

				// 配置不可
				if (current->map[address1] != 0 || current->map[address2] != 0)
				{
					continue;
				}

				node_type* node = AllocNode();

				node->block.piece1.type = piece1;
				node->block.piece1.x = x2;
				node->block.piece1.y = y2;
				node->block.piece2.type = piece2;
				node->block.piece2.x = x;
				node->block.piece2.y = y;
				node->dir = dirs[i];

				// マップ内容を親から継承する
				::memcpy(node->map, current->map, m_MapSize);

				// 配置
				node->map[address1] = piece2;
				node->map[address2] = piece1;

				// リンク
				AddChileNode(current, node);

				// 評価
				Evaluation(node);

				// 評価値を親に伝播させる
				tjs_int value = node->value;
				node_type::pointer_type tmp = node->pParent;

				while (tmp != nullptr)
				{
					if (value <= tmp->value)
					{
						break;
					}
					tmp->value = value;
					tmp = tmp->pParent;
				}
			}
		}

//		std::cout << "end CalcNextStep() function" << std::endl;

		ShiftCandidate(m_Root);
	};

	/*
	* マップの評価関数
	*/
	void Evaluation(node_type* current)
	{
		static map_type checked;
		tjs_int value = 0;
		bool isErase = false;

		checked.resize(m_MapSize);
		ClearMap(checked);

		// 連結数計算（ただし、１ピースのみであればカウントしない）
		for (tjs_int y = 0; y < m_Height; y++)
		{
			for (tjs_int x = 0; x < m_Width; x++)
			{
				tjs_int address = y * m_Width + x;

				if (checked[address] || current->map[address] == 0)
				{
					checked[address] = 1;
					continue;
				}

				tjs_int v = GetLinkCount(x, y, current->map[address], current->map, checked);

				if (v > 1)
				{
					value += v;

					// 消える？
					if (v >= m_Linking)
					{
						isErase = true;
					}
				}
			}
		}

		// 連鎖数計算
		if (isErase)
		{
			current->chain = GetChainCount(current);
			// 連鎖が発生しなかった場合はfireをfalseに
			current->fire = (current->chain > 0);
		}
		else
		{
			current->chain = 0;
			current->fire = false;
		}

		// 評価値の最終決定ロジックを修正
		if (current->fire && current->chain >= m_MaxChain)
		{
			// 連鎖数がm_MaxChain以上なら、連鎖による評価値を加算
			current->myValue = value + (current->chain * 100);
			current->value = current->myValue;
		}
		else
		{
			// それ以外の場合は、連鎖の評価値は加算しない
			if (current->fire)
			{
				current->myValue = value;
				current->value = 0;
			}
			else
			{
				current->myValue = value;
				current->value = value;
			}


			// 2. 最終評価値 (value) を決定
			if (IsDangerState(current))
			{
				// 危機回避モード: 連鎖数や目標を無視し、目の前の消去を最優先する
				// myValueから連鎖ボーナスを除去し、連結数と連鎖発生そのものを評価する
				current->value = value + (current->fire ? 500 : 0); // 例: 消去発生に高い固定点
			}
			else
			{
				// 通常モード: 連鎖目標を達成できているかチェック
				if (current->fire && current->chain >= m_MaxChain)
				{
					// 連鎖目標達成: myValueをそのまま最終評価値とする
					current->value = current->myValue;
				}
				else
				{
					// 連鎖目標未達成: 連鎖ボーナスを無視する
					current->value = value;
				}
			}
		}

		if (m_Debug)
		{
			DumpNodeMap(current);
		}
	};

	/*
	* ぷよが連結している数を返す
	*/
	tjs_int GetLinkCount(const tjs_int start_x, const tjs_int start_y, const tjs_int type, const tjs_int* map, map_type& checked) const
	{
		tjs_int address1 = start_y * m_Width + start_x;

		// スタート位置が有効か、チェック済みか、タイプが一致するか確認
		if (!IsValidPos(start_x, start_y) || checked[address1] || map[address1] != type) {
			return 0;
		}

		tjs_int count = 0;
		std::vector<Pos> queue;

		// スタート位置をキューに追加し、チェック済みとする
		queue.push_back(Pos(start_x, start_y));
		checked[address1] = 1;
		count++;

		size_t head = 0;
		while (head < queue.size()) {
			Pos current = queue[head++];

			// 上下左右の隣接ノードを探索
			const int dx[] = { 1, -1, 0, 0 };
			const int dy[] = { 0, 0, 1, -1 };

			for (int i = 0; i < 4; ++i) {
				tjs_int next_x = current.m_x + dx[i];
				tjs_int next_y = current.m_y + dy[i];
				tjs_int address2 = next_y * m_Width + next_x;

				// 隣接ノードが有効な座標で、未チェック、かつ同じタイプであればキューに追加
				if (IsValidPos(next_x, next_y) && !checked[address2] && map[address2] == type) {
					queue.push_back(Pos(next_x, next_y));
					checked[address2] = 1;
					count++;
				}
			}
		}
		return count;
	}
	/*
	* 連鎖する回数を返す
	*/
	tjs_int GetChainCount(node_type* node)
	{
		// シミュレーション用のマップコピー
		std::vector<tjs_int> simulation_map(m_MapSize);
		memcpy(simulation_map.data(), node->map, m_MapSize);

		// 最初の消去をチェック
		bool first_erase_occurred = false;
		map_type checked(m_MapSize);

		if (CountAndMarkConnectedPieces(node->block.piece1.x, node->block.piece1.y, simulation_map, checked) >= m_Linking) {
			first_erase_occurred = true;
		}
		if (CountAndMarkConnectedPieces(node->block.piece2.x, node->block.piece2.y, simulation_map, checked) >= m_Linking) {
			first_erase_occurred = true;
		}

		if (!first_erase_occurred) {
			return 0;
		}

		tjs_int chain_count = 1;

		// 連鎖が続く限りループ
		while (true) {
			// 現在のマップ状態のキャッシュキーを作成
			std::vector<tjs_int> current_map_state = simulation_map;

			// ピースを落下させる
			std::vector<Pos> dropped_pieces;
			DropPiecese(simulation_map.data(), dropped_pieces);

			// キャッシュチェック
			if (m_ChainCountCache.count(current_map_state)) {
				chain_count += m_ChainCountCache[current_map_state];
				break; // キャッシュに存在するので連鎖計算を終了
			}

			bool next_erase_occurred = false;
			ClearMap(checked);

			for (const auto& pos : dropped_pieces) {
				//std::cout << "落ちてきたピース: (" << pos.m_x << ", " << pos.m_y << ") is normal : " << IsNormalPiece(simulation_map[pos.m_y * m_Width + pos.m_x]) << std::endl;
				if (IsNormalPiece(simulation_map[pos.m_y * m_Width + pos.m_x])) {
					if (CountAndMarkConnectedPieces(pos.m_x, pos.m_y, simulation_map, checked) >= m_Linking) {
						next_erase_occurred = true;
					}
				}
			}

			if (next_erase_occurred) {
				chain_count++;
			}
			else {
				// キャッシュに結果を保存
				m_ChainCountCache[current_map_state] = chain_count - 1; // 1連鎖目を除く
				break;
			}
		}
		memcpy(node->map, simulation_map.data(), m_MapSize);

		return chain_count;
	}

	/**
	 * @brief 連結したピースを数え、同時に消去済みとしてマークする反復関数
	 * @param x, y 開始座標
	 * @param map マップデータ（消去対象は-1に書き換えられる）
	 * @param checked チェック済み状態を管理するマップ
	 * @return 連結数
	 */
	tjs_int CountAndMarkConnectedPieces(const tjs_int start_x, const tjs_int start_y, std::vector<tjs_int>& map, map_type& checked)
	{
		const tjs_int start_type = map[start_y * m_Width + start_x];
		if (start_type == 0 || start_type == -1 || checked[start_y * m_Width + start_x]) {
			return 0;
		}

		// 連結しているピースの座標を一時的に格納するベクトル
		std::vector<Pos> connected_pieces;
		std::vector<Pos> queue;
		queue.push_back(Pos(start_x, start_y));
		checked[start_y * m_Width + start_x] = 1;

		size_t head = 0;
		while (head < queue.size()) {
			const Pos current = queue[head++];
			const tjs_int current_address = current.m_y * m_Width + current.m_x;

			if (map[current_address] == start_type) {
				connected_pieces.push_back(current);

				const int dx[] = { 1, -1, 0, 0 };
				const int dy[] = { 0, 0, 1, -1 };

				for (int i = 0; i < 4; ++i) {
					const tjs_int next_x = current.m_x + dx[i];
					const tjs_int next_y = current.m_y + dy[i];
					const tjs_int next_address = next_y * m_Width + next_x;

					if (IsValidPos(next_x, next_y) && !checked[next_address] && map[next_address] == start_type) {
						queue.push_back(Pos(next_x, next_y));
						checked[next_address] = 1;
					}
				}
			}
		}

		// 連結数が消去条件を満たしている場合
		if (connected_pieces.size() >= static_cast<size_t>(m_Linking)) {
			// 消去対象のピースをマーク
			for (const auto& pos : connected_pieces) {
				map[pos.m_y * m_Width + pos.m_x] = -1;
				//std::cout << "消去ピース: " << pos.m_x << ", " << pos.m_y << ")" << std::endl;
			}

			// おじゃまぷよを消すための追加処理
			for (const auto& pos : connected_pieces) {
				const int dx[] = { 1, -1, 0, 0 };
				const int dy[] = { 0, 0, 1, -1 };

				for (int i = 0; i < 4; ++i) {
					const tjs_int next_x = pos.m_x + dx[i];
					const tjs_int next_y = pos.m_y + dy[i];

					if (IsValidPos(next_x, next_y)) {
						const tjs_int next_address = next_y * m_Width + next_x;
						// 隣接するピースがおじゃまぷよであり、かつまだ消去済みでない場合
						// m_OjamaTypesは、おじゃまぷよのタイプを保持する`std::vector`を想定
						if (IsOjamaPiece(map[next_address])) {
							map[next_address] = -1; // おじゃまぷよを消去済みとしてマーク
						}
					}
				}
			}
		}

		return connected_pieces.size();
	}

	/**
	 * @brief ピースを落下させる最適化された関数
	 * @param map マップデータ
	 * @param dropped_pieces 落下したピースの座標を格納するベクトル
	 */
	void DropPiecese(tjs_int* map, std::vector<Pos>& dropped_pieces)
	{
		dropped_pieces.clear();
		for (tjs_int x = 0; x < m_Width; x++) {
			tjs_int write_y = m_Height - 1;
			for (tjs_int y = m_Height - 1; y >= 0; y--) {
				tjs_int address1	 = y * m_Width + x;
				if (map[address1] != -1) {
					if (write_y != y) {
						tjs_int address2 = write_y * m_Width + x;
						map[address2] = map[address1];
						if (map[address2] != 0) {
							dropped_pieces.push_back(Pos(x, write_y));
						}
						map[y * m_Width + x] = 0;
					}
					write_y--;
				}
				else {
					map[y * m_Width + x] = 0;
				}
			}
		}
	};

	/**/
	node_type::pointer_type GetNextBlockFromList(node_type::pointer_type list)
	{
		if (!list || !list->first_child) return nullptr;

		node_type::pointer_type best = nullptr;
		tjs_int maxValue = std::numeric_limits<tjs_int>::lowest();

		for (node_type::pointer_type child = list->first_child; child; child = child->next_sibling)
		{
			if (child->value > maxValue)
			{
				maxValue = child->value;
				best = child;
			}
		}

		return best;
	}

	/**/
	void ShiftCandidate(node_type::pointer_type node)
	{
		if (!node || !node->first_child) {
			return;
		}

		// 子ノードを一時的なリストに集める
		std::vector<node_type::pointer_type> children;
		node_type::pointer_type current = node->first_child;
		while (current) {
			ShiftCandidate(current); // 再帰的に子ノードを処理
			children.push_back(current);
			current = current->next_sibling;
		}

		// 評価値で降順にソート
		std::sort(children.begin(), children.end(), [](const node_type::pointer_type& a, const node_type::pointer_type& b) {
			return a->value > b->value;
		});

		// 上位3つ（またはそれ以下）のノードを新しいリストに再構築
		node->first_child = nullptr;
		node_type::pointer_type last_child = nullptr;
		size_t count = 0;
		for (auto& child : children) {
			if (count >= 2) {
				// 上位3つを超えたノードは削除
				DeleteNodeIterative(child);
			}
			else {
				// 上位3つを残す
				child->next_sibling = nullptr;
				if (last_child) {
					last_child->next_sibling = child;
				}
				else {
					node->first_child = child;
				}
				last_child = child;
				count++;
			}
		}
	}
	/**/
	void RemoveNodesBelowValue(node_type::pointer_type parent, tjs_int threshold)
	{
		if (!parent) return;

		node_type::pointer_type current = parent->first_child;
		node_type::pointer_type prev = nullptr;

		while (current)
		{
			if (current->value < threshold)
			{
				// 子孫も含めて削除
				DeleteNodeIterative(current);

				// リストからノードを外す
				if (prev)
				{
					prev->next_sibling = current->next_sibling;
				}
				else
				{
					parent->first_child = current->next_sibling;
				}
				current = current->next_sibling;
			}
			else
			{
				// 生き残るノードは再帰的にチェック
				RemoveNodesBelowValue(current, threshold);
				prev = current;
				current = current->next_sibling;
			}
		}
	}

	/**/
	void DeleteNodeIterative(node_type::pointer_type root)
	{
		if (!root) {
			return;
		}

		std::vector<node_type::pointer_type> stack;
		stack.push_back(root);

		while (!stack.empty()) {
			node_type::pointer_type current = stack.back();

			// 子ノードがまだスタックにプッシュされていない場合
			if (current->first_child) {
				// 子ノードをスタックにプッシュ
				node_type::pointer_type child = current->first_child;
				while (child) {
					stack.push_back(child);
					child = child->next_sibling;
				}
				// 子ノードを処理するために、現在のノードはスタックに残しておく
				current->first_child = nullptr; // これが、子ノードが処理済みであるというフラグの役割を果たす
			}
			else {
				// 子ノードがすべて処理済み、または子ノードがない場合、ノードを削除
				stack.pop_back();

				// アロケータからメモリを解放
				for (auto alloc : m_Alloc) {
					if (alloc->HasPointer(current)) {
						alloc->Deallocate(current);
						break;
					}
				}
			}
		}
	}

	/**/
	void ClearMap(map_type& map) const
	{
		std::fill(map.begin(), map.end(), 0);
	};

	/**/
	void AddChileNode(node_type::pointer_type parent, node_type::pointer_type child)
	{
		if (!parent || !child)
		{
			return;
		}

		child->pParent = parent;
		child->next_sibling = parent->first_child;
		parent->first_child = child;
	}

	/*
	* 指定されたノードのmapを標準出力にダンプする
	*/
	void DumpNodeMap(node_type::pointer_type node)
	{
		if (!node) {
			std::cout << "Error: The specified node is NULL." << std::endl;
			return;
		}

		// PuzzleDirectionを文字列に変換するヘルパー関数
		auto getDirString = [](bm88::details::PuzzleDirection dir) -> std::string {
			switch (dir) {
			case bm88::details::PuzzleDirection::DIR_UP:
				return "UP";
			case bm88::details::PuzzleDirection::DIR_DOWN:
				return "DOWN";
			case bm88::details::PuzzleDirection::DIR_LEFT:
				return "LEFT";
			case bm88::details::PuzzleDirection::DIR_RIGHT:
				return "RIGHT";
			default:
				return "UNKNOWN";
			}
		};

		// ノードの基本情報と評価値を表示
		std::cout << "--- Puzzle Node Dump ---" << std::endl;
		std::cout << "Value: " << node->value << std::endl;
		std::cout << "My Value: " << node->myValue << std::endl;
		std::cout << "Chain: " << node->chain << std::endl;
		std::cout << "Fire: " << (node->fire ? "true" : "false") << std::endl;

		// dirの文字列表示を追加
		std::cout << "Direction: " << getDirString(node->dir) << std::endl;

		// 盤面情報を表示
		std::cout << "Map (Width=" << m_Width << ", Height=" << m_Height << "):" << std::endl;
		std::cout << "Piece1 : (" << node->block.piece1.x << ", " << node->block.piece1.y << ") type : " << node->block.piece1.type << std::endl;
		std::cout << "Piece2 : (" << node->block.piece2.x << ", " << node->block.piece2.y << ") type : " << node->block.piece2.type << std::endl;
		for (tjs_int y = 0; y < m_Height; y++)
		{
			std::cout << "| ";
			for (tjs_int x = 0; x < m_Width; x++)
			{
				std::cout << node->map[y * m_Width + x] << " ";
			}
			std::cout << "|" << std::endl;
		}
		std::cout << "------------------------" << std::endl;
	}

	allocators m_Alloc;
	tjs_int m_EntryX;
	tjs_int m_EntryY;
	tjs_int m_Width;
	tjs_int m_Height;
	tjs_int m_MapSize;
	tjs_int m_SizeOfNode;

	vector_type m_OjamaTypes;

	// マップの状態をキャッシュするマップ
	std::unordered_map<std::vector<tjs_int>, tjs_int, MapHasher> m_ChainCountCache;

	tjs_int m_Level;
	tjs_int m_MaxChain;
	tjs_int m_Linking;

	node_type::pointer_type m_Root;

	tjs_int m_Debug;
};

/**/
NCB_REGISTER_CLASS(PuzzleAICore)
{
	Constructor();

	Method("setEntryPoint", &Class::SetEntryPoint);

	Method("setLevel", &Class::SetLevel);
	Method("setLinking", &Class::SetLinking);

	Method("setMapSize", &Class::SetMapSize);
	Method("addOjamaType", &Class::AddOjamaType);

	Method("setOjamaPieces", &Class::SetOjamaPieces);

	Method("addNextBlock", &Class::AddNextBlock);
	Method("getNextBlock", &Class::GetNextBlock);

	Method("setNextRoot", &Class::SetNextRoot);

	Method("clear", &Class::Clear);
	Method("initializeRootNode", &Class::InitializeRootNode);

	Method("dumpRootMap", &Class::DumpRootMap);
	Method("setDebugMode", &Class::SetDebugMode);

	Method("getRootMap", &Class::GetRootMap);

	Property("level", &Class::GetLevel, 0);
	Property("linking", &Class::GetLinking, 0);
};


