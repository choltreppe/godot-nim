import std/math as stdmath
import std/endians {.all.}
export stdmath except
  sin, cos, tan,
  arcsin, arccos, arctan, arctan2
export builtin_bswap16, builtin_bswap32, builtin_bswap64

import ../typedefs

const SQRT12* = 0.7071067811865475244008443621048490
const SQRT2* = 1.4142135623730950488016887242
const LN2* = 0.6931471805599453094172321215

# Make room for our constexpr's below by overriding potential system-specific macros.
#undef ABS
#undef SIGN
#undef MIN
#undef MAX
#undef CLAMP

# Generic ABS function, for math uses please use Math::abs.

template sign*[T](x: T): T = cmp(T, 0)

func min*[T](x: T; xs: varargs[T]): T =
  result = x
  for i in 0..high(xs):
    if xs[i] < result: result = xs[i]

func max*[T](x: T; xs: varargs[T]): T =
  result = x
  for i in 0..high(xs):
    if xs[i] > result: result = xs[i]

# Function to find the next power of 2 to an integer.
template nextPowerOf2*(x: uint32): uint32 =
  if x == 0: return 0
  var x = x-1
  x = x or (x shr 1)
  x = x or (x shr 2)
  x = x or (x shr 4)
  x = x or (x shr 8)
  x = x or (x shr 16)
  x+1

# Function to find the previous power of 2 to an integer.
template previousPowerOf2*(x: uint32): uint32 =
  var x = x
  x = x or (x shr 1)
  x = x or (x shr 2)
  x = x or (x shr 4)
  x = x or (x shr 8)
  x = x or (x shr 16)
  x - (x shr 1)

# Function to find the closest power of 2 to an integer.
template closestPowerOf2*(x: uint32): uint32 =
  let
    nx = next_power_of_2(x)
    px = previous_power_of_2(x)
  if (nx - x) > (x - px): px
  else: nx

# Get a shift value from a power of 2.
func getShiftFromPowerOf2*(pBits: uint32): int32 {.inline.} =
  for i in 0..<32:
    if pBits == uint32(1 shl i): return int32 i
  return -1


template nearestPowerOf2Templated*[T](x: T): T =
  var x = x-1
  let num = getShiftFromPowerOf2(sizeof(T)) + 3
  for i in 0..<num: x = x or x.shr(1.shl i)
  return x+1

# Function to find the nearest (bigger) power of 2 to an integer.
func nearestShift*(pNumber: uint32): uint32 {.inline.} =
  for i in countdown(30, 0):
    if (p_number and uint32(1 shl i)) != 0:
      return uint32 i + 1
  return 0

# constexpr function to find the floored log2 of a number
func floorLog2*[T: SomeOrdinal](x: T): T =
  if x < 2: x
  else: 1 + floorLog2(x shr 1)

# Get the number of bits needed to represent the number.
# IE, if you pass in 8, you will get 4.
# If you want to know how many bits are needed to store 8 values however, pass in (8 - 1).
func getNumBits*[T](x: T): T = floor_log2(x)

#========#
#  Math  #
#========#

# This epsilon should match the one used by Godot for consistency.
# Using `f` when `real_t` is float.
const CMP_EPSILON = 0.00001f
const CMP_EPSILON2 = (CMP_EPSILON * CMP_EPSILON)

# This epsilon is for values related to a unit size (scalar or vector len).
const UNIT_EPSILON = 0.00001

# Functions reproduced as in Godot's source code `math_funcs.h`.
# Some are overloads to automatically support changing real_t into either double or float in the way Godot does.

func fposMod*[T: SomeFloat](pX, pY: T): T {.inline.} =
  result = floorMod(pX, pY)
  if ((result < 0 and pY > 0) or (result > 0 and pY < 0)):
    result += pY

func fposModp*[T: SomeFloat](pX, pY: T): T {.inline.} =
  result = floorMod(pX, pY)
  if result < 0:
    result += pY

func posMod*[T: SomeInteger](pX, pY: T): T {.inline.} =
  result = pX mod pY
  if ((result < 0 and pY > 0) or (result > 0 and pY < 0)):
    result += pY

{.push, inline.}
func sin*[T: SomeFloat](pX: Radian[T]): T = stdmath.sin T(pX)
func cos*[T: SomeFloat](pX: Radian[T]): T = stdmath.cos T(pX)
func tan*[T: SomeFloat](pX: Radian[T]): T = stdmath.tan T(pX)

func sinc*[T: SomeFloat](pX: T): T = (if pX == 0: 1 else: sin(pX)/pX)
func sinc*[T: SomeFloat](pX: Radian[T]): T = sinc T(pX)

func sincn*[T: SomeFloat](pX: T): T = sinc(PI * pX)
func sincn*[T: SomeFloat](pX: Radian[T]): T = sincn T(pX)

func arcsin*[T: SomeFloat](pX: T): Radian[T] = Radian stdmath.arcsin pX
func arccos*[T: SomeFloat](pX: T): Radian[T] = Radian stdmath.arccos pX
func arctan*[T: SomeFloat](pX: T): Radian[T] = Radian stdmath.arctan pX
func arctan2*[T: SomeFloat](pY, pX: T): Radian[T] = Radian stdmath.arctan2(pY, pX)
{.pop.}

func isFinite*[T: SomeFloat](pX: T): bool = pX == NaN or pX == Inf or pX == NegInf

{.warning: "TODO: importing from c++ is not done yet.".}
#[
inline double cubic_interpolate_in_time(double p_from, double p_to, double p_pre, double p_post, double p_weight,
    double p_to_t, double p_pre_t, double p_post_t) {
  /* Barry-Goldman method */
  double t = Math::lerp(0.0, p_to_t, p_weight);
  double a1 = Math::lerp(p_pre, p_from, p_pre_t == 0 ? 0.0 : (t - p_pre_t) / -p_pre_t);
  double a2 = Math::lerp(p_from, p_to, p_to_t == 0 ? 0.5 : t / p_to_t);
  double a3 = Math::lerp(p_to, p_post, p_post_t - p_to_t == 0 ? 1.0 : (t - p_to_t) / (p_post_t - p_to_t));
  double b1 = Math::lerp(a1, a2, p_to_t - p_pre_t == 0 ? 0.0 : (t - p_pre_t) / (p_to_t - p_pre_t));
  double b2 = Math::lerp(a2, a3, p_post_t == 0 ? 1.0 : t / p_post_t);
  return Math::lerp(b1, b2, p_to_t == 0 ? 0.5 : t / p_to_t);
}

inline float cubic_interpolate_in_time(float p_from, float p_to, float p_pre, float p_post, float p_weight,
    float p_to_t, float p_pre_t, float p_post_t) {
  /* Barry-Goldman method */
  float t = Math::lerp(0.0f, p_to_t, p_weight);
  float a1 = Math::lerp(p_pre, p_from, p_pre_t == 0 ? 0.0f : (t - p_pre_t) / -p_pre_t);
  float a2 = Math::lerp(p_from, p_to, p_to_t == 0 ? 0.5f : t / p_to_t);
  float a3 = Math::lerp(p_to, p_post, p_post_t - p_to_t == 0 ? 1.0f : (t - p_to_t) / (p_post_t - p_to_t));
  float b1 = Math::lerp(a1, a2, p_to_t - p_pre_t == 0 ? 0.0f : (t - p_pre_t) / (p_to_t - p_pre_t));
  float b2 = Math::lerp(a2, a3, p_post_t == 0 ? 1.0f : t / p_post_t);
  return Math::lerp(b1, b2, p_to_t == 0 ? 0.5f : t / p_to_t);
}

inline double cubic_interpolate_angle_in_time(double p_from, double p_to, double p_pre, double p_post, double p_weight,
    double p_to_t, double p_pre_t, double p_post_t) {
  double from_rot = fmod(p_from, Math_TAU);

  double pre_diff = fmod(p_pre - from_rot, Math_TAU);
  double pre_rot = from_rot + fmod(2.0 * pre_diff, Math_TAU) - pre_diff;

  double to_diff = fmod(p_to - from_rot, Math_TAU);
  double to_rot = from_rot + fmod(2.0 * to_diff, Math_TAU) - to_diff;

  double post_diff = fmod(p_post - to_rot, Math_TAU);
  double post_rot = to_rot + fmod(2.0 * post_diff, Math_TAU) - post_diff;

  return cubic_interpolate_in_time(from_rot, to_rot, pre_rot, post_rot, p_weight, p_to_t, p_pre_t, p_post_t);
}

inline float cubic_interpolate_angle_in_time(float p_from, float p_to, float p_pre, float p_post, float p_weight,
    float p_to_t, float p_pre_t, float p_post_t) {
  float from_rot = fmod(p_from, (float)Math_TAU);

  float pre_diff = fmod(p_pre - from_rot, (float)Math_TAU);
  float pre_rot = from_rot + fmod(2.0f * pre_diff, (float)Math_TAU) - pre_diff;

  float to_diff = fmod(p_to - from_rot, (float)Math_TAU);
  float to_rot = from_rot + fmod(2.0f * to_diff, (float)Math_TAU) - to_diff;

  float post_diff = fmod(p_post - to_rot, (float)Math_TAU);
  float post_rot = to_rot + fmod(2.0f * post_diff, (float)Math_TAU) - post_diff;

  return cubic_interpolate_in_time(from_rot, to_rot, pre_rot, post_rot, p_weight, p_to_t, p_pre_t, p_post_t);
}

inline double bezier_interpolate(double p_start, double p_control_1, double p_control_2, double p_end, double p_t) {
  /* Formula from Wikipedia article on Bezier curves. */
  double omt = (1.0 - p_t);
  double omt2 = omt * omt;
  double omt3 = omt2 * omt;
  double t2 = p_t * p_t;
  double t3 = t2 * p_t;

  return p_start * omt3 + p_control_1 * omt2 * p_t * 3.0 + p_control_2 * omt * t2 * 3.0 + p_end * t3;
}

inline float bezier_interpolate(float p_start, float p_control_1, float p_control_2, float p_end, float p_t) {
  /* Formula from Wikipedia article on Bezier curves. */
  float omt = (1.0f - p_t);
  float omt2 = omt * omt;
  float omt3 = omt2 * omt;
  float t2 = p_t * p_t;
  float t3 = t2 * p_t;

  return p_start * omt3 + p_control_1 * omt2 * p_t * 3.0f + p_control_2 * omt * t2 * 3.0f + p_end * t3;
}

template <typename T>
inline T clamp(T x, T minv, T maxv) {
  if (x < minv) {
    return minv;
  }
  if (x > maxv) {
    return maxv;
  }
  return x;
}

inline double deg_to_rad(double p_y) {
  return p_y * Math_PI / 180.0;
}
inline float deg_to_rad(float p_y) {
  return p_y * static_cast<float>(Math_PI) / 180.f;
}

inline double rad_to_deg(double p_y) {
  return p_y * 180.0 / Math_PI;
}
inline float rad_to_deg(float p_y) {
  return p_y * 180.f / static_cast<float>(Math_PI);
}

inline double inverse_lerp(double p_from, double p_to, double p_value) {
  return (p_value - p_from) / (p_to - p_from);
}
inline float inverse_lerp(float p_from, float p_to, float p_value) {
  return (p_value - p_from) / (p_to - p_from);
}

inline double remap(double p_value, double p_istart, double p_istop, double p_ostart, double p_ostop) {
  return Math::lerp(p_ostart, p_ostop, Math::inverse_lerp(p_istart, p_istop, p_value));
}
inline float remap(float p_value, float p_istart, float p_istop, float p_ostart, float p_ostop) {
  return Math::lerp(p_ostart, p_ostop, Math::inverse_lerp(p_istart, p_istop, p_value));
}

inline bool is_equal_approx(float a, float b) {
  # Check for exact equality first, required to handle "infinity" values.
  if (a == b) {
    return true;
  }
  # Then check for approximate equality.
  float tolerance = (float)CMP_EPSILON * abs(a);
  if (tolerance < (float)CMP_EPSILON) {
    tolerance = (float)CMP_EPSILON;
  }
  return abs(a - b) < tolerance;
}

inline bool is_equal_approx(float a, float b, float tolerance) {
  # Check for exact equality first, required to handle "infinity" values.
  if (a == b) {
    return true;
  }
  # Then check for approximate equality.
  return abs(a - b) < tolerance;
}

inline bool is_zero_approx(float s) {
  return abs(s) < (float)CMP_EPSILON;
}

inline bool is_equal_approx(double a, double b) {
  # Check for exact equality first, required to handle "infinity" values.
  if (a == b) {
    return true;
  }
  # Then check for approximate equality.
  double tolerance = CMP_EPSILON * abs(a);
  if (tolerance < CMP_EPSILON) {
    tolerance = CMP_EPSILON;
  }
  return abs(a - b) < tolerance;
}

inline bool is_equal_approx(double a, double b, double tolerance) {
  # Check for exact equality first, required to handle "infinity" values.
  if (a == b) {
    return true;
  }
  # Then check for approximate equality.
  return abs(a - b) < tolerance;
}

inline bool is_zero_approx(double s) {
  return abs(s) < CMP_EPSILON;
}

inline float absf(float g) {
  union {
    float f;
    uint32_t i;
  } u;

  u.f = g;
  u.i &= 2147483647u;
  return u.f;
}

inline double absd(double g) {
  union {
    double d;
    uint64_t i;
  } u;
  u.d = g;
  u.i &= (uint64_t)9223372036854775807ull;
  return u.d;
}

inline double smoothstep(double p_from, double p_to, double p_weight) {
  if (is_equal_approx(static_cast<real_t>(p_from), static_cast<real_t>(p_to))) {
    return p_from;
  }
  double x = clamp((p_weight - p_from) / (p_to - p_from), 0.0, 1.0);
  return x * x * (3.0 - 2.0 * x);
}
inline float smoothstep(float p_from, float p_to, float p_weight) {
  if (is_equal_approx(p_from, p_to)) {
    return p_from;
  }
  float x = clamp((p_weight - p_from) / (p_to - p_from), 0.0f, 1.0f);
  return x * x * (3.0f - 2.0f * x);
}

inline double move_toward(double p_from, double p_to, double p_delta) {
  return std::abs(p_to - p_from) <= p_delta ? p_to : p_from + sign(p_to - p_from) * p_delta;
}

inline float move_toward(float p_from, float p_to, float p_delta) {
  return std::abs(p_to - p_from) <= p_delta ? p_to : p_from + sign(p_to - p_from) * p_delta;
}

inline double linear2db(double p_linear) {
  return log(p_linear) * 8.6858896380650365530225783783321;
}
inline float linear2db(float p_linear) {
  return log(p_linear) * 8.6858896380650365530225783783321f;
}

inline double db2linear(double p_db) {
  return exp(p_db * 0.11512925464970228420089957273422);
}
inline float db2linear(float p_db) {
  return exp(p_db * 0.11512925464970228420089957273422f);
}

inline double round(double p_val) {
  return (p_val >= 0) ? floor(p_val + 0.5) : -floor(-p_val + 0.5);
}
inline float round(float p_val) {
  return (p_val >= 0) ? floor(p_val + 0.5f) : -floor(-p_val + 0.5f);
}

inline int64_t wrapi(int64_t value, int64_t min, int64_t max) {
  int64_t range = max - min;
  return range == 0 ? min : min + ((((value - min) % range) + range) % range);
}

inline float wrapf(real_t value, real_t min, real_t max) {
  const real_t range = max - min;
  return is_zero_approx(range) ? min : value - (range * floor((value - min) / range));
}

inline float fract(float value) {
  return value - floor(value);
}

inline double fract(double value) {
  return value - floor(value);
}

inline float pingpong(float value, float length) {
  return (length != 0.0f) ? abs(fract((value - length) / (length * 2.0f)) * length * 2.0f - length) : 0.0f;
}

inline double pingpong(double value, double length) {
  return (length != 0.0) ? abs(fract((value - length) / (length * 2.0)) * length * 2.0 - length) : 0.0;
}

# This function should be as fast as possible and rounding mode should not matter.
inline int fast_ftoi(float a) {
  static int b;

#if (defined(_WIN32_WINNT) && _WIN32_WINNT >= 0x0603) || WINAPI_FAMILY == WINAPI_FAMILY_PHONE_APP # windows 8 phone?
  b = (int)((a > 0.0) ? (a + 0.5) : (a - 0.5));

#elif defined(_MSC_VER) && _MSC_VER < 1800
  __asm fld a __asm fistp b
  /*#elif defined( __GNUC__ ) && ( defined( __i386__ ) || defined( __x86_64__ ) )
  # use AT&T inline assembly style, document that
  # we use memory as output (=m) and input (m)
  __asm__ __volatile__ (
  "flds %1        \n\t"
  "fistpl %0      \n\t"
  : "=m" (b)
  : "m" (a));*/

#else
  b = lrintf(a); # assuming everything but msvc 2012 or earlier has lrint
#endif
  return b;
}

inline double snapped(double p_value, double p_step) {
  if (p_step != 0) {
    p_value = Math::floor(p_value / p_step + 0.5) * p_step;
  }
  return p_value;
}

inline float snap_scalar(float p_offset, float p_step, float p_target) {
  return p_step != 0 ? Math::snapped(p_target - p_offset, p_step) + p_offset : p_target;
}

inline float snap_scalar_separation(float p_offset, float p_step, float p_target, float p_separation) {
  if (p_step != 0) {
    float a = Math::snapped(p_target - p_offset, p_step + p_separation) + p_offset;
    float b = a;
    if (p_target >= 0) {
      b -= p_separation;
    } else {
      b += p_step;
    }
    return (Math::abs(p_target - a) < Math::abs(p_target - b)) ? a : b;
  }
  return p_target;
}
]#