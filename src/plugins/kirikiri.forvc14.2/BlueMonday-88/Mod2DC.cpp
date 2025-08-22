/*
 $Author: halo $
 $Revision: 22 $
*/


#include"ncbind.hpp"


/**/
namespace bm88 {
	namespace details {

		/**/
		template <class T>
		class Mod2DCVectorModel
		{
		public:
			typedef	T	value_type;

		public:
			Mod2DCVectorModel(value_type x, value_type y) : m_x(x), m_y(y)
			{
			};
			Mod2DCVectorModel(const Mod2DCVectorModel& rhs)
			{
				Assign(rhs);
			};
			~Mod2DCVectorModel()
			{
			};

			inline Mod2DCVectorModel& Assign(const Mod2DCVectorModel& rhs)
			{
				m_x = rhs.m_x;
				m_y = rhs.m_y;
				return (*this);
			};
			inline Mod2DCVectorModel& Add(const Mod2DCVectorModel& rhs)
			{
				m_x += rhs.m_x;
				m_y += rhs.m_y;
				return (*this);
			};
			inline Mod2DCVectorModel& Sub(const Mod2DCVectorModel& rhs)
			{
				m_x -= rhs.m_x;
				m_y -= rhs.m_y;
				return (*this);
			};
			inline Mod2DCVectorModel& Mul(const value_type& rhs)
			{
				m_x *= rhs;
				m_y *= rhs;
				return (*this);
			};
			inline Mod2DCVectorModel& Div(const value_type& rhs)
			{
				m_x /= rhs;
				m_y /= rhs;
				return (*this);
			};

		public:
			value_type	m_x, m_y;
		};

		template <class T>
		inline Mod2DCVectorModel<T> operator+(const Mod2DCVectorModel<T>& lhs, const Mod2DCVectorModel<T>& rhs)
		{
			return Mod2DCVectorModel<T>(lhs).Add(rhs);
		};
		template <class T>
		inline Mod2DCVectorModel<T> operator-(const Mod2DCVectorModel<T>& lhs, const Mod2DCVectorModel<T>& rhs)
		{
			return Mod2DCVectorModel<T>(lhs).Sub(rhs);
		};
		template <class T>
		inline Mod2DCVectorModel<T> operator*(const Mod2DCVectorModel<T>& lhs, const T& rhs)
		{
			return Mod2DCVectorModel<T>(lhs).Mul(rhs);
		};
		template <class T>
		inline Mod2DCVectorModel<T> operator*(const T& lhs, const Mod2DCVectorModel<T>& rhs)
		{
			return Mod2DCVectorModel<T>(rhs).Mul(lhs);
		};
	};
};

/**/
class Mod2DC
{
public:
	typedef bm88::details::Mod2DCVectorModel<tjs_real>	vector_type;
	typedef vector_type									point_type;

	typedef vector_type::value_type						value_type;

public:
	Mod2DC() :
		m_Intersection(0, 0), m_Intersect(false)
	{
	};
	virtual
	~Mod2DC()
	{
	};

	/*
	矩形１と矩形２が交差するかどうか判定する。
	交差する場合は true を返す。
	それ以外は false を返す。
	*/
	bool IntersectRect(
		tjs_int left1, tjs_int top1, tjs_int right1, tjs_int bottom1,
		tjs_int left2, tjs_int top2, tjs_int right2, tjs_int bottom2
	);

	/*
	線分A-B と線分C-D が交差するかどうか判定する。
	交差する場合は true を返す。
	それ以外は false を返す。
	交差する場合も交差しない場合も
	IntersectionX, IntersectionY に交点をセットする。
	*/
	bool IntersectLineSegment(
		tjs_int Ax, tjs_int Ay,
		tjs_int Bx, tjs_int By,
		tjs_int Cx, tjs_int Cy,
		tjs_int Dx, tjs_int Dy
	);

	value_type GetIntersectionX() const
	{
		return m_Intersection.m_x;
	};
	value_type GetIntersectionY() const
	{
		return m_Intersection.m_y;
	};

private:
	point_type	m_Intersection;
	bool		m_Intersect;
};

/**/
bool Mod2DC::IntersectRect(tjs_int left1, tjs_int top1, tjs_int right1, tjs_int bottom1,
							tjs_int left2, tjs_int top2, tjs_int right2, tjs_int bottom2)
{
	return static_cast<bool>(
		left1 <= right2 && left2 <= right1 && top1 <= bottom2 && top2 <= bottom1
	);
}

/**/
bool Mod2DC::IntersectLineSegment(tjs_int Ax, tjs_int Ay, tjs_int Bx, tjs_int By,
									tjs_int Cx, tjs_int Cy, tjs_int Dx, tjs_int Dy)
{
	point_type ptA(Ax, Ay), ptB(Bx, By);
	point_type ptC(Cx, Cy), ptD(Dx, Dy);
	vector_type ab(ptB - ptA);
	vector_type cd(ptD - ptC);
	value_type denom = (ab.m_x * cd.m_y) - (ab.m_y * cd.m_x); // よくわからん式１

	// 状態初期化
	m_Intersect = false;

	// 平行
	if(denom == 0.0)
		return false;

	// よくわからん式２
	vector_type ac(ptC - ptA);
	value_type abr = ((cd.m_y * ac.m_x) - (cd.m_x * ac.m_y)) / denom;
	value_type cdr = ((ab.m_y * ac.m_x) - (ab.m_x * ac.m_y)) / denom;

	m_Intersection = ptA + (abr * ab);

	// abr, cdr ともに 0 ～ 1 の間ならば交差している
	if((abr > 0.0 && abr <= 1.0) && (cdr > 0.0 && cdr <= 1.0))
		m_Intersect = true;

	return m_Intersect;
}

/**/
NCB_REGISTER_CLASS(Mod2DC)
{
	Constructor();

	Method("intersectRect", &Class::IntersectRect);
	Method("intersectLineSegment", &Class::IntersectLineSegment);

	Property("intersectionX", &Class::GetIntersectionX, 0);
	Property("intersectionY", &Class::GetIntersectionY, 0);
};


