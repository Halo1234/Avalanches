/*
*/


#include<vector>
#include<iostream>
#include<type_traits>
#include <unordered_set>
#include <unordered_map>
#include <functional>
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
			PuzzlePiece piece1;		// ��]��
			PuzzlePiece piece2;		// ��]��
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
			pointer_type first_child;    // <--- �ŏ��̎q�����w��
			pointer_type next_sibling;   // <--- ���̌Z����w��
			tjs_int map[1];

			// �f�X�g���N�^��ǉ�
			~PuzzleNode()
			{
				// �����o�|�C���^�̉���͍s��Ȃ��i�A���P�[�^�ŊǗ����邽�߁j
			}
		};

		/*
		* �A���P�[�^
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
			// �R�s�[�R���X�g���N�^�ƃR�s�[������Z�q���폜
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

				// �A���C�������g���\���̂ɍ��킹��
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

public:
	/**/
	PuzzleAICore() :
		m_Alloc(),
		m_Width(0), m_Height(0),
		m_SizeOfNode(0),
		m_MapSize(0),
		m_Level(0), m_MaxChain(0), m_Linking(0),
		m_Root(NULL)
	{
	};
	/**/
	virtual ~PuzzleAICore()
	{
		// �f�X�g���N�^�Ŋm�ۂ����A���P�[�^��S�ĉ������
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
			TVPThrowExceptionMessage(TJS_W("�L����AI���x����0�`4�͈̔͂ł��B"));
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
			TVPThrowExceptionMessage(TJS_W("SetLinking()�Ɏw��ł��鐔��2�ȏ�ł��B"));
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

		// ���[�g�����
		m_Root = AllocNode();
	};
	/**/
	void AddOjamaType(const tjs_int type)
	{
		m_OjamaTypes.push_back(type);
	};

	/*
	* piece1:��]��
	* piece2:��]��
	*/
	void AddNextBlock(const tjs_int piece1, const tjs_int piece2)
	{
		NextStep(m_Root, piece1, piece2);
	};

private:
	/*
	* �ǉ������A���P�[�^��Ԃ�
	*/
	allocator_type* AddAllocator()
	{
		// �V�����A���P�[�^�𓮓I�Ɋm��
		allocator_type* new_alloc = new allocator_type();
		new_alloc->SetBlockSizeAndCount(m_SizeOfNode, PUZZLE_NODE_MAX_COUNT);
		m_Alloc.push_back(new_alloc);

		return new_alloc;
	};
	/**/
	void FreeAllocators()
	{
		// vector���̊e�|�C���^���폜
		for (auto alloc : m_Alloc)
		{
			delete alloc;
		}
		// vector���N���A
		m_Alloc.clear();
	};

	/**/
	node_type* AllocNode()
	{
		void* raw = NULL;
		allocator_type* target_alloc = NULL;

		// �����̃A���P�[�^�����Ɏ���
		for (auto alloc : m_Alloc)
		{
			raw = alloc->Allocate();
			if (raw != NULL)
			{
				target_alloc = alloc;
				break;
			}
		}

		// �����̃A���P�[�^�Ŋm�ۂł��Ȃ������ꍇ
		if (raw == NULL)
		{
			target_alloc = AddAllocator();
			raw = target_alloc->Allocate();

			if (raw == NULL)
			{
				// ����ł��m�ۂł��Ȃ��ꍇ�͗�O
				TVPThrowExceptionMessage(TJS_W("AI�̌v�Z�̈�̃������m�ۂɎ��s���܂����B"));
			}
		}

		::memset(raw, 0, m_SizeOfNode);

		// raw��nullptr�ł͂Ȃ����Ƃ��m�F���Ă���new���s��
		// ����ň��S�ɃI�u�W�F�N�g���\�z�ł���
		node_type* p = new(raw) node_type();

		return p;
	}

	/*
	* ���W���L�����`�F�b�N
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
	* ���̎���v�Z����
	*/
	void NextStep(node_type* current, const tjs_int piece1, const tjs_int piece2)
	{
		// �q�m�[�h���Ȃ��ꍇ�A�܂�current���t�m�[�h�̏ꍇ
		if (current->first_child == nullptr)
		{
			// ���̃m�[�h�ɐV�������ǉ�
			CalcNextStep(current, piece1, piece2);
		}
		else
		{
			// �q�m�[�h������ꍇ�A�e�q�m�[�h�ɑ΂��čċA�I�Ɏ��̎���v�Z
			node_type::pointer_type child = current->first_child;
			while (child != nullptr)
			{
				NextStep(child, piece1, piece2);
				child = child->next_sibling;
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

		if (current == NULL)
		{
			return;
		}

		for (tjs_int i = 0; i < KIM_ARRAY_COUNT(dirs); i++)
		{
			// �܂��͉�]���̈ʒu�����肷��
			for (tjs_int x = 0; x < m_Width; x++)
			{
				// x��0�܂��͍ő�l�̏ꍇ�A�����ɂ���Ă͔z�u�ł��Ȃ�
				if ((x == 0 && dirs[i] == bm88::details::PuzzleDirection::DIR_LEFT) ||
					(x == (m_Width - 1) && dirs[i] == bm88::details::PuzzleDirection::DIR_RIGHT))
				{
					continue;
				}

				// y�ʒu�����肷��
				tjs_int y = 0;
				for (y = m_Height - 1; y >= 0; y--)
				{
					if (current->map[y * m_Width + x] == 0)
					{
						break;
					}
				}

				// DIR_DOWN�̎���y�����ɂ��炷
				if (dirs[i] == bm88::details::PuzzleDirection::DIR_DOWN)
				{
					y--;
					if (y < 1)
					{
						continue;
					}
				}

				// y���ő�l�̏ꍇ�A�����ɂ���Ă͔z�u�ł��Ȃ�
				// y��1�̏ꍇ�z�u�ł��Ȃ�
				if (y == 1 || ((y == m_Height - 1) && dirs[i] == bm88::details::PuzzleDirection::DIR_DOWN))
				{
					continue;
				}

				// ��]���ʒu�����肷��
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

				// �z�u�s��
				if (current->map[y * m_Width + x] != 0 || current->map[y2 * m_Width + x2] != 0)
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

				// �}�b�v���e��e����p������
				::memcpy(node->map, current->map, m_MapSize);

				// �z�u
				node->map[y * m_Width + x] = piece1;
				node->map[y2 * m_Width + x2] = piece2;

				// �����N
				AddChileNode(current, node);

				// �]��
				Evaluation(node);

				// �]���l��e�ɓ`�d������
				tjs_int value = node->value;
				node_type::pointer_type tmp = node->pParent;

				if (tmp != NULL)
				{
					if (value > tmp->value)
					{
						while (tmp != NULL)
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
	* �}�b�v�̕]���֐�
	*/
	void Evaluation(node_type* current)
	{
		static map_type checked;
		tjs_int value = 0;
		bool isErase = false;

		checked.resize(m_MapSize);
		ClearMap(checked);

		// �A�����v�Z�i�������A�P�s�[�X�݂̂ł���΃J�E���g���Ȃ��j
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

					// ������H
					if (v >= m_Linking)
					{
						isErase = true;
					}
				}
			}
		}

		ClearMap(checked);

		current->chain = GetChainCount(current, checked);
		current->fire = (current->chain == 0 ? false : true);

		if (current->chain >= m_MaxChain)
		{
			// �A���J�n
			current->myValue = current->value = value + (current->chain * 100);
		}
		else
		{
			// �A�������Ȃ�
			current->myValue = current->value = value;
		}

		current->value = value;

		// �A�����v�Z
		if (isErase)
		{
			ClearMap(checked);

			current->chain = GetChainCount(current, checked);
		}
	};

	/*
	* �Ղ悪�A�����Ă��鐔��Ԃ�
	*/
	tjs_int GetLinkCount(const tjs_int x, const tjs_int y, const tjs_int type, const tjs_int* map, map_type& checked) const
	{
		if (!IsValidPos(x, y))
		{
			return 0;
		}

		tjs_int address = y * m_Width + x;

		if (checked[address])
		{
			return 0;
		}

		tjs_int p = map[address];
		tjs_int v = 0;

		if (p == type)
		{
			checked[address] = 1;

			v++;
			v += GetLinkCount(x + 1, y, p, map, checked);
			v += GetLinkCount(x - 1, y, p, map, checked);
			v += GetLinkCount(x, y + 1, p, map, checked);
			v += GetLinkCount(x, y - 1, p, map, checked);
		}

		return v;
	};
	/*
	* �A������񐔂�Ԃ�
	*/
	tjs_int GetChainCount(node_type* node, map_type& checked)
	{
		tjs_int c = 0;
		tjs_int l1 = GetLinkCount(node->block.piece1.x, node->block.piece1.y, node->block.piece1.type, node->map, checked);
		tjs_int l2 = GetLinkCount(node->block.piece2.x, node->block.piece2.y, node->block.piece2.type, node->map, checked);

		if (l1 >= m_Linking || l2 >= m_Linking)
		{
			c++;

			if (l1 >= m_Linking)
			{
				MarkErasePiecese(node->block.piece1.x, node->block.piece1.y, node->block.piece1.type, node->map, checked);
			}
			if (l2 >= m_Linking)
			{
				MarkErasePiecese(node->block.piece2.x, node->block.piece2.y, node->block.piece2.type, node->map, checked);
			}

			tjs_int link;
			pos_type drop;

			do
			{
				drop.clear();
				ClearMap(checked);

				DropPiecese(node->map, drop);

				bool isErase = false;

				for (pos_type::iterator ite = drop.begin(); ite != drop.end(); ite++)
				{
					link = GetLinkCount(ite->m_x, ite->m_y, node->map[ite->m_y * m_Width + ite->m_x], node->map, checked);
					if (link >= m_Linking)
					{
						isErase = true;
						MarkErasePiecese(ite->m_x, ite->m_y, node->map[ite->m_y * m_Width + ite->m_x], node->map, checked);
					}
				}

				if (isErase)
				{
					c++;
				}
			} while (!drop.empty());
		}

		return c;
	};
	/*
	* ��������Ղ���}�[�N
	*/
	tjs_int MarkErasePiecese(const tjs_int x, const tjs_int y, const tjs_int type, tjs_int* map, map_type& checked)
	{
		if (!IsValidPos(x, y))
		{
			return 0;
		}

		tjs_int address = y * m_Width + x;

		if (checked[address])
		{
			return 0;
		}
		checked[address] = 1;

		// �q�����Ă��Ȃ�
		if (map[address] != type)
		{
			return 0;
		}

		map[address] = -1;
		tjs_int c = 1;

		c += MarkErasePiecese(x + 1, y, type, map, checked);
		c += MarkErasePiecese(x - 1, y, type, map, checked);
		c += MarkErasePiecese(x, y + 1, type, map, checked);
		c += MarkErasePiecese(x, y - 1, type, map, checked);

		return c;
	};
	/**/
	void DropPiecese(tjs_int* map, pos_type& drop)
	{
		for (tjs_int y = m_Height - 1; y >= 0; y--)
		{
			for (tjs_int x = 0; x < m_Width; x++)
			{
				tjs_int address1 = y * m_Width + x;

				if (map[address1] != -1)
				{
					continue;
				}

				for (tjs_int i = y - 1; i >= 0; i--)
				{
					tjs_int address2 = y * m_Width + i;

					if (map[address1] == -1 || map[address2] == 0)
					{
						continue;
					}

					map[address1] = map[address2];
					map[address2] = 0;
					drop.push_back(Pos(x, y));
				}
			}
		}
	};

	/**/
	void ShiftCandidate(node_type::pointer_type node)
	{
		if (!node)
		{
			return;
		}

		// �V�����f�[�^�\���ɍ��킹�čċA�Ăяo��
		node_type::pointer_type child = node->first_child;
		while (child != nullptr)
		{
			ShiftCandidate(child);
			child = child->next_sibling;
		}

		// �ő�l��T��
		tjs_int max = 0;
		child = node->first_child;
		while (child != nullptr)
		{
			if (child->value > max)
			{
				max = child->value;
			}
			child = child->next_sibling;
		}

		// �ő�l�����̃m�[�h���폜
		RemoveNodesBelowValue(node, max);
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
				// �q�����܂߂čċA�I�ɍ폜
				DeleteNodeRecursive(current);

				// ���X�g����m�[�h���O��
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
				// �����c��m�[�h�͍ċA�I�Ƀ`�F�b�N
				RemoveNodesBelowValue(current, threshold);
				prev = current;
				current = current->next_sibling;
			}
		}
	}

	/**/
	void DeleteNodeRecursive(node_type::pointer_type node)
	{
		if (!node) return;

		// �܂��q�m�[�h�����ׂčċA�I�ɍ폜
		node_type::pointer_type current = node->first_child;
		while (current)
		{
			node_type::pointer_type next = current->next_sibling;
			DeleteNodeRecursive(current);
			current = next;
		}

		// �f�X�g���N�^�𖾎��I�ɌĂяo���istd::vector�͖����̂ŕs�v�����A�x�X�g�v���N�e�B�X�Ƃ��āj
		// node->~PuzzleNode();

		// �A���P�[�^���烁���������
		for (auto alloc : m_Alloc)
		{
			if (alloc->HasPointer(node))
			{
				alloc->Deallocate(node);
				break;
			}
		}
	};

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

	Method("setMapSize", &Class::SetMapSize);
	Method("addOjamaType", &Class::AddOjamaType);

	Method("addNextBlock", &Class::AddNextBlock);

	Property("level", &Class::GetLevel, 0);
	Property("linking", &Class::GetLinking, 0);
};


