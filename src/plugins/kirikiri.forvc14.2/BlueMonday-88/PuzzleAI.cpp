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
			PuzzlePiece piece1;		// 回転軸
			PuzzlePiece piece2;		// 回転側
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
	// マップの状態をキャッシュするマップ
	std::unordered_map<std::vector<tjs_int>, tjs_int, MapHasher> m_ChainCountCache;


public:
	/**/
	PuzzleAICore() :
		m_Alloc(),
		m_Width(0), m_Height(0),
		m_SizeOfNode(0),
		m_MapSize(0),
		m_Level(0), m_MaxChain(0), m_Linking(0),
		m_Root(nullptr)
	{
	};
	/**/
	virtual ~PuzzleAICore()
	{
		// デストラクタで確保したアロケータを全て解放する
		FreeAllocators();
	};

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
		tTJSVariant value(next->block.piece1.x);

		dictObj->PropSet(TJS_MEMBERENSURE, TJS_W("x1"), nullptr, &value, dictObj);
		value = next->block.piece1.y;
		dictObj->PropSet(TJS_MEMBERENSURE, TJS_W("y1"), nullptr, &value, dictObj);
		value = next->block.piece1.type;
		dictObj->PropSet(TJS_MEMBERENSURE, TJS_W("type1"), nullptr, &value, dictObj);

		value = next->block.piece2.x;
		dictObj->PropSet(TJS_MEMBERENSURE, TJS_W("x2"), nullptr, &value, dictObj);
		value = next->block.piece2.y;
		dictObj->PropSet(TJS_MEMBERENSURE, TJS_W("y2"), nullptr, &value, dictObj);
		value = next->block.piece2.type;
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

		for (tjs_int i = 0; i < KIM_ARRAY_COUNT(dirs); i++)
		{
			// まずは回転軸の位置を決定する
			for (tjs_int x = 0; x < m_Width; x++)
			{
				// xが0または最大値の場合、向きによっては配置できない
				if ((x == 0 && dirs[i] == bm88::details::PuzzleDirection::DIR_LEFT) ||
					(x == (m_Width - 1) && dirs[i] == bm88::details::PuzzleDirection::DIR_RIGHT))
				{
					continue;
				}

				// y位置を決定する
				tjs_int y = 0;
				for (y = m_Height - 1; y >= 0; y--)
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
				// yが1の場合配置できない
				if (y == 1 || ((y == m_Height - 1) && dirs[i] == bm88::details::PuzzleDirection::DIR_DOWN))
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
				for (tjs_int tmp = y2 + 1; tmp < m_Height; tmp++)
				{
					if (current->map[tmp * m_Width + x2] == 0 && (x == x2 && y == (y2 - 1)))
					{
						y2++;
						if (y2 >= m_Height)
						{
							y2 = m_Height - 1;
						}
					}
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
				node->block.piece1.x = x;
				node->block.piece1.y = y;
				node->block.piece2.type = piece2;
				node->block.piece2.x = x2;
				node->block.piece2.y = y2;
				node->dir = dirs[i];

				// マップ内容を親から継承する
				::memcpy(node->map, current->map, m_MapSize);

				// 配置
				node->map[address1] = piece1;
				node->map[address2] = piece2;

				// リンク
				AddChileNode(current, node);

				// 評価
				Evaluation(node);

				// 評価値を親に伝播させる
				tjs_int value = node->value;
				node_type::pointer_type tmp = node->pParent;

				if (tmp != nullptr)
				{
					if (value > tmp->value)
					{
						while (tmp != nullptr)
						{
							tmp->value = value;
							tmp = tmp->pParent;
						}
					}
				}
			}
		}

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
					value += v * 2;

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
			current->myValue = value;
			current->value = value;
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

			// キャッシュチェック
			if (m_ChainCountCache.count(current_map_state)) {
				chain_count += m_ChainCountCache[current_map_state];
				break; // キャッシュに存在するので連鎖計算を終了
			}

			// ピースを落下させる
			std::vector<Pos> dropped_pieces;
			DropPiecese(simulation_map.data(), dropped_pieces);

			bool next_erase_occurred = false;
			ClearMap(checked);

			for (const auto& pos : dropped_pieces) {
				if (simulation_map[pos.m_y * m_Width + pos.m_x] != 0) {
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
		tjs_int address = start_y * m_Width + start_x;
		const tjs_int start_type = map[address];
		if (start_type == 0 || checked[address]) {
			return 0;
		}

		tjs_int count = 0;
		std::vector<Pos> queue;
		queue.push_back(Pos(start_x, start_y));
		checked[address] = 1;

		size_t head = 0;
		while (head < queue.size()) {
			const Pos current = queue[head++];
			const tjs_int current_address = current.m_y * m_Width + current.m_x;

			if (map[current_address] == start_type) {
				count++;

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

		// 消去対象のピースをマークする
		if (count >= m_Linking) {
			for (const auto& pos : queue) {
				map[pos.m_y * m_Width + pos.m_x] = -1;
			}
		}

		return count;
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

	/**/
	void DumpMap(node_type::pointer_type node)
	{
		std::cout << "value = " << node->value << "(x : " << node->block.piece1.x << ", y : " << node->block.piece1.y << ") dir : " << (tjs_int)node->dir << std::endl;
		for (tjs_int y = 0; y < m_Height; y++)
		{
			for (tjs_int x = 0; x < m_Width; x++)
			{
				std::cout << node->map[y * m_Width + x] << ",";
			}
			std::cout << std::endl;
		}
	};

	allocators m_Alloc;
	tjs_int m_Width;
	tjs_int m_Height;
	tjs_int m_MapSize;
	tjs_int m_SizeOfNode;

	vector_type m_OjamaTypes;

	tjs_int m_Level;
	tjs_int m_MaxChain;
	tjs_int m_Linking;

	node_type* m_Root;
};

/**/
NCB_REGISTER_CLASS(PuzzleAICore)
{
	Constructor();

	Method("setLevel", &Class::SetLevel);
	Method("setLinking", &Class::SetLinking);

	Method("setMapSize", &Class::SetMapSize);
	Method("addOjamaType", &Class::AddOjamaType);

	Method("addNextBlock", &Class::AddNextBlock);
	Method("getNextBlock", &Class::GetNextBlock);

	Method("setNextRoot", &Class::SetNextRoot);

	Property("level", &Class::GetLevel, 0);
	Property("linking", &Class::GetLinking, 0);
};


