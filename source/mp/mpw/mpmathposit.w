% This file is part of MetaPost. The MetaPost program is in the public domain.

@ Introduction.

TODO: collect constants like decimal
TODO: share scanners and random

@c
# include "mpconfig.h"
# include "mpmathposit.h"

@h

@ @c
@<Declarations@>

@ @(mpmathposit.h@>=
# ifndef MPMATHPOSIT_H
# define MPMATHPOSIT_H 1

# include "mp.h"
# include "softposit.h"

math_data *mp_initialize_posit_math (MP mp);

# endif

@* Math initialization.

First, here are some very important constants.

@d mp_fraction_multiplier  4096
@d mp_angle_multiplier     16
@d mp_warning_limit        pow(2.0,52)

@d odd(A)                  (abs(A)%2==1)

@d two_to_the(A)           (1<<(unsigned)(A))
@d set_cur_cmd(A)          mp->cur_mod_->command = (A)
@d set_cur_mod(A)          mp->cur_mod_->data.n.data.pval = (A)

@ Here are the functions that are static as they are not used elsewhere.

@<Declarations@>=
static void   mp_allocate_abs                    (MP mp, mp_number *n, mp_number_type t, mp_number *v);
static void   mp_allocate_clone                  (MP mp, mp_number *n, mp_number_type t, mp_number *v);
static void   mp_allocate_double                 (MP mp, mp_number *n, double v);
static void   mp_allocate_number                 (MP mp, mp_number *n, mp_number_type t);
static int    mp_posit_ab_vs_cd                  (mp_number *a, mp_number *b, mp_number *c, mp_number *d);
static void   mp_posit_abs                       (mp_number *A);
static void   mp_posit_crossing_point            (MP mp, mp_number *ret, mp_number *a, mp_number *b, mp_number *c);
static void   mp_posit_fraction_to_round_scaled  (mp_number *x);
static void   mp_posit_m_exp                     (MP mp, mp_number *ret, mp_number *x_orig);
static void   mp_posit_m_log                     (MP mp, mp_number *ret, mp_number *x_orig);
static void   mp_posit_m_norm_rand               (MP mp, mp_number *ret);
static void   mp_posit_m_unif_rand               (MP mp, mp_number *ret, mp_number *x_orig);
static void   mp_posit_n_arg                     (MP mp, mp_number *ret, mp_number *x, mp_number *y);
static void   mp_posit_number_make_fraction      (MP mp, mp_number *r, mp_number *p, mp_number *q);
static void   mp_posit_number_make_scaled        (MP mp, mp_number *r, mp_number *p, mp_number *q);
static void   mp_posit_number_take_fraction      (MP mp, mp_number *r, mp_number *p, mp_number *q);
static void   mp_posit_number_take_scaled        (MP mp, mp_number *r, mp_number *p, mp_number *q);
static void   mp_posit_power_of                  (MP mp, mp_number *r, mp_number *a, mp_number *b);
static void   mp_posit_print_number              (MP mp, mp_number *n);
static void   mp_posit_pyth_add                  (MP mp, mp_number *r, mp_number *a, mp_number *b);
static void   mp_posit_pyth_sub                  (MP mp, mp_number *r, mp_number *a, mp_number *b);
static void   mp_posit_scan_fractional_token     (MP mp, int n);
static void   mp_posit_scan_numeric_token        (MP mp, int n);
static void   mp_posit_set_precision             (MP mp);
static void   mp_posit_sin_cos                   (MP mp, mp_number *z_orig, mp_number *n_cos, mp_number *n_sin);
static void   mp_posit_slow_add                  (MP mp, mp_number *ret, mp_number *x_orig, mp_number *y_orig);
static void   mp_posit_square_rt                 (MP mp, mp_number *ret, mp_number *x_orig);
static void   mp_posit_velocity                  (MP mp, mp_number *ret, mp_number *st, mp_number *ct, mp_number *sf, mp_number *cf, mp_number *t);
static void   mp_free_posit_math                 (MP mp);
static void   mp_free_number                     (MP mp, mp_number *n);
static void   mp_init_randoms                    (MP mp, int seed);
static void   mp_number_abs_clone                (mp_number *A, mp_number *B);
static void   mp_number_add                      (mp_number *A, mp_number *B);
static void   mp_number_add_scaled               (mp_number *A, int B); /* also for negative B */
static void   mp_number_angle_to_scaled          (mp_number *A);
static void   mp_number_clone                    (mp_number *A, mp_number *B);
static void   mp_number_divide_int               (mp_number *A, int B);
static void   mp_number_double                   (mp_number *A);
static int    mp_number_equal                    (mp_number *A, mp_number *B);
static void   mp_number_floor                    (mp_number *i);
static void   mp_number_fraction_to_scaled       (mp_number *A);
static int    mp_number_greater                  (mp_number *A, mp_number *B);
static void   mp_number_half                     (mp_number *A);
static int    mp_number_less                     (mp_number *A, mp_number *B);
static void   mp_number_modulo                   (mp_number *a, mp_number *b);
static void   mp_number_multiply_int             (mp_number *A, int B);
static void   mp_number_negate                   (mp_number *A);
static void   mp_number_negated_clone            (mp_number *A, mp_number *B);
static int    mp_number_nonequalabs              (mp_number *A, mp_number *B);
static int    mp_number_odd                      (mp_number *A);
static void   mp_number_scaled_to_angle          (mp_number *A);
static void   mp_number_scaled_to_fraction       (mp_number *A);
static void   mp_number_subtract                 (mp_number *A, mp_number *B);
static void   mp_number_swap                     (mp_number *A, mp_number *B);
static int    mp_number_to_boolean               (mp_number *A);
static double mp_number_to_double                (mp_number *A);
static int    mp_number_to_int                   (mp_number *A);
static int    mp_number_to_scaled                (mp_number *A);
static int    mp_round_unscaled                  (mp_number *x_orig);
static void   mp_set_posit_from_addition         (mp_number *A, mp_number *B, mp_number *C);
static void   mp_set_posit_from_boolean          (mp_number *A, int B);
static void   mp_set_posit_from_div              (mp_number *A, mp_number *B, mp_number *C);
static void   mp_set_posit_from_double           (mp_number *A, double B);
static void   mp_set_posit_from_int              (mp_number *A, int B);
static void   mp_set_posit_from_int_div          (mp_number *A, mp_number *B, int C);
static void   mp_set_posit_from_int_mul          (mp_number *A, mp_number *B, int C);
static void   mp_set_posit_from_mul              (mp_number *A, mp_number *B, mp_number *C);
static void   mp_set_posit_from_of_the_way       (MP mp, mp_number *A, mp_number *t, mp_number *B, mp_number *C);
static void   mp_set_posit_from_scaled           (mp_number *A, int B);
static void   mp_set_posit_from_subtraction      (mp_number *A, mp_number *B, mp_number *C);
static void   mp_set_posit_half_from_addition    (mp_number *A, mp_number *B, mp_number *C);
static void   mp_set_posit_half_from_subtraction (mp_number *A, mp_number *B, mp_number *C);
static void   mp_wrapup_numeric_token            (MP mp, unsigned char *start, unsigned char *stop);
static char  *mp_posit_number_tostring           (MP mp, mp_number *n);

typedef struct mp_posit_info {
    posit_t    unity;
    posit_t    zero;
    posit_t    one;
    posit_t    two;
    posit_t    three;
    posit_t    four;
    posit_t    five;
    posit_t    eight;
    posit_t    seven;
    posit_t    sixteen;
    posit_t    half_unit;
    posit_t    minusone;
    posit_t    three_quarter_unit;
    posit_t    d16;
    posit_t    d64;
    posit_t    d256;
    posit_t    d4096;
    posit_t    d65536;
    posit_t    dp90;
    posit_t    dp180;
    posit_t    dp270;
    posit_t    dp360;
    posit_t    dm90;
    posit_t    dm180;
    posit_t    dm270;
    posit_t    dm360;
    posit_t    fraction_multiplier;
    posit_t    negative_fraction_multiplier; /* todo: also in decimal */
    posit_t    angle_multiplier;
    posit_t    fraction_one;
    posit_t    fraction_two;
    posit_t    fraction_three;
    posit_t    fraction_four;
    posit_t    fraction_half;
    posit_t    fraction_one_and_half;
    posit_t    one_eighty_degrees;
    posit_t    negative_one_eighty_degrees;
    posit_t    three_sixty_degrees;
    posit_t    no_crossing;
    posit_t    one_crossing;
    posit_t    zero_crossing;
    posit_t    error_correction;
    posit_t    pi;
    posit_t    pi_divided_by_180;
    posit_t    epsilon;
    posit_t    EL_GORDO;
    posit_t    negative_EL_GORDO;
    posit_t    one_third_EL_GORDO;
    posit_t    coef;
    posit_t    coef_bound;
    posit_t    scaled_threshold;
    posit_t    fraction_threshold;
    posit_t    equation_threshold;
    posit_t    near_zero_angle;
    posit_t    p_over_v_threshold;
    posit_t    warning_limit;
    posit_t    sqrt_two_mul_fraction_one;
    posit_t    sqrt_five_minus_one_mul_fraction_one_and_half;
    posit_t    three_minus_sqrt_five_mul_fraction_one_and_half;
    posit_t    d180_divided_by_pi_mul_angle;
    int        initialized;
} mp_posit_info;

static mp_posit_info mp_posit_data = {
    .initialized = 0,
};

inline static posit_t mp_posit_make_fraction (posit_t p, posit_t q) { return posit_mul(posit_div(p,q), mp_posit_data.fraction_multiplier); }
inline static posit_t mp_posit_take_fraction (posit_t p, posit_t q) { return posit_div(posit_mul(p,q), mp_posit_data.fraction_multiplier); }
inline static posit_t mp_posit_make_scaled   (posit_t p, posit_t q) { return posit_div(p,q); }

math_data *mp_initialize_posit_math(MP mp)
{
    math_data *math = (math_data *) mp_memory_allocate(sizeof(math_data));
    /* alloc */
    if (! mp_posit_data.initialized) {
        mp_posit_data.initialized                  = 1;
        mp_posit_data.unity                        = integer_to_posit(1);
        mp_posit_data.zero                         = integer_to_posit(0);
        mp_posit_data.one                          = integer_to_posit(1);
        mp_posit_data.two                          = integer_to_posit(2);
        mp_posit_data.three                        = integer_to_posit(3);
        mp_posit_data.four                         = integer_to_posit(4);
        mp_posit_data.five                         = integer_to_posit(5);
        mp_posit_data.seven                        = integer_to_posit(7);
        mp_posit_data.eight                        = integer_to_posit(8);
        mp_posit_data.sixteen                      = integer_to_posit(16);
        mp_posit_data.dp90                         = integer_to_posit(90);
        mp_posit_data.dp180                        = integer_to_posit(180);
        mp_posit_data.dp270                        = integer_to_posit(270);
        mp_posit_data.dp360                        = integer_to_posit(360);
        mp_posit_data.dm90                         = integer_to_posit(-90);
        mp_posit_data.dm180                        = integer_to_posit(-180);
        mp_posit_data.dm270                        = integer_to_posit(-270);
        mp_posit_data.dm360                        = integer_to_posit(-360);
        mp_posit_data.d16                          = integer_to_posit(16);
        mp_posit_data.d64                          = integer_to_posit(64);
        mp_posit_data.d256                         = integer_to_posit(256);
        mp_posit_data.d4096                        = integer_to_posit(4096);
        mp_posit_data.d65536                       = integer_to_posit(65536);
        mp_posit_data.minusone                     = posit_neg(mp_posit_data.one);
        mp_posit_data.half_unit                    = posit_div(mp_posit_data.unity, mp_posit_data.two);
        mp_posit_data.three_quarter_unit           = posit_mul(mp_posit_data.three, posit_div(mp_posit_data.unity,mp_posit_data.four));
        mp_posit_data.fraction_multiplier          = integer_to_posit(mp_fraction_multiplier);
        mp_posit_data.negative_fraction_multiplier = posit_neg(mp_posit_data.fraction_multiplier);
        mp_posit_data.angle_multiplier             = integer_to_posit(mp_angle_multiplier);
        mp_posit_data.fraction_one                 = mp_posit_data.fraction_multiplier;
        mp_posit_data.fraction_two                 = posit_mul(mp_posit_data.fraction_multiplier, mp_posit_data.two);
        mp_posit_data.fraction_three               = posit_mul(mp_posit_data.fraction_multiplier, mp_posit_data.three);
        mp_posit_data.fraction_four                = posit_mul(mp_posit_data.fraction_multiplier, mp_posit_data.four);
        mp_posit_data.fraction_half                = posit_div(mp_posit_data.fraction_multiplier, mp_posit_data.two);
        mp_posit_data.fraction_one_and_half        = posit_add(mp_posit_data.fraction_multiplier, mp_posit_data.fraction_half);
        mp_posit_data.one_eighty_degrees           = posit_mul(mp_posit_data.angle_multiplier, mp_posit_data.dp180);
        mp_posit_data.negative_one_eighty_degrees  = posit_mul(mp_posit_data.angle_multiplier, mp_posit_data.dm180);
        mp_posit_data.three_sixty_degrees          = posit_mul(mp_posit_data.angle_multiplier, mp_posit_data.dp360);
        mp_posit_data.no_crossing                  = posit_add(mp_posit_data.fraction_multiplier, mp_posit_data.one);
        mp_posit_data.one_crossing                 = mp_posit_data.fraction_multiplier;
        mp_posit_data.zero_crossing                = mp_posit_data.zero;
        mp_posit_data.error_correction             = double_to_posit(1E-12);                                                              /* debatable */
        mp_posit_data.warning_limit                = posit_pow(mp_posit_data.two, integer_to_posit(52));                                  /* this is a large value that can just be expressed without loss of precision */
        mp_posit_data.pi                           = double_to_posit(3.1415926535897932384626433832795028841971);
        mp_posit_data.pi_divided_by_180            = posit_div(mp_posit_data.pi, mp_posit_data.dp180);
        mp_posit_data.epsilon                      = posit_pow(mp_posit_data.two, integer_to_posit(-52.0));
        mp_posit_data.EL_GORDO                     = posit_sub(posit_div(double_to_posit(DBL_MAX),mp_posit_data.two), mp_posit_data.one); /* the largest value that \MP\ likes. */
        mp_posit_data.negative_EL_GORDO            = posit_neg(mp_posit_data.EL_GORDO);
        mp_posit_data.one_third_EL_GORDO           = posit_div(mp_posit_data.EL_GORDO, mp_posit_data.three);
        mp_posit_data.coef                         = posit_div(mp_posit_data.seven, mp_posit_data.three);                                       /* |fraction| approximation to 7/3 */
        mp_posit_data.coef_bound                   = posit_mul(mp_posit_data.coef, mp_posit_data.fraction_multiplier);
        mp_posit_data.scaled_threshold             = double_to_posit(0.000122);                                                           /* a |scaled| coefficient less than this is zeroed */
        mp_posit_data.near_zero_angle              = posit_mul(double_to_posit(0.0256), mp_posit_data.angle_multiplier);                  /* an angle of about 0.0256 */
        mp_posit_data.p_over_v_threshold           = integer_to_posit(0x80000);
        mp_posit_data.equation_threshold           = double_to_posit(0.001);

        mp_posit_data.sqrt_two_mul_fraction_one =
            posit_mul(
                posit_sqrt(mp_posit_data.two),
                mp_posit_data.fraction_one
            );

        mp_posit_data.sqrt_five_minus_one_mul_fraction_one_and_half =
            posit_mul(
                posit_mul(
                    mp_posit_data.three,
                    mp_posit_data.fraction_half
                ),
                posit_sub(
                    posit_sqrt(mp_posit_data.five),
                    mp_posit_data.one
                )
            );

        mp_posit_data.three_minus_sqrt_five_mul_fraction_one_and_half =
            posit_mul(
                posit_mul(
                    mp_posit_data.three,
                    mp_posit_data.fraction_half
                ),
                posit_sub(
                    mp_posit_data.three,
                    posit_sqrt(mp_posit_data.five)
                )
            );

        mp_posit_data.d180_divided_by_pi_mul_angle =
            posit_mul(
                posit_div(
                    mp_posit_data.dp180,
                    mp_posit_data.pi
                ),
                mp_posit_data.angle_multiplier
            );

    }
    /* alloc */
    math->md_allocate        = mp_allocate_number;
    math->md_free            = mp_free_number;
    math->md_allocate_clone  = mp_allocate_clone;
    math->md_allocate_abs    = mp_allocate_abs;
    math->md_allocate_double = mp_allocate_double;
    /* precission */
    mp_allocate_number(mp, &math->md_precision_default, mp_scaled_type);
    mp_allocate_number(mp, &math->md_precision_max, mp_scaled_type);
    mp_allocate_number(mp, &math->md_precision_min, mp_scaled_type);
    /* here are the constants for |scaled| objects */
    mp_allocate_number(mp, &math->md_epsilon_t, mp_scaled_type);
    mp_allocate_number(mp, &math->md_inf_t, mp_scaled_type);
    mp_allocate_number(mp, &math->md_negative_inf_t, mp_scaled_type);
    mp_allocate_number(mp, &math->md_warning_limit_t, mp_scaled_type);
    mp_allocate_number(mp, &math->md_one_third_inf_t, mp_scaled_type);
    mp_allocate_number(mp, &math->md_unity_t, mp_scaled_type);
    mp_allocate_number(mp, &math->md_two_t, mp_scaled_type);
    mp_allocate_number(mp, &math->md_three_t, mp_scaled_type);
    mp_allocate_number(mp, &math->md_half_unit_t, mp_scaled_type);
    mp_allocate_number(mp, &math->md_three_quarter_unit_t, mp_scaled_type);
    mp_allocate_number(mp, &math->md_zero_t, mp_scaled_type);
    /* |fractions| */
    mp_allocate_number(mp, &math->md_arc_tol_k, mp_fraction_type);
    mp_allocate_number(mp, &math->md_fraction_one_t, mp_fraction_type);
    mp_allocate_number(mp, &math->md_fraction_half_t, mp_fraction_type);
    mp_allocate_number(mp, &math->md_fraction_three_t, mp_fraction_type);
    mp_allocate_number(mp, &math->md_fraction_four_t, mp_fraction_type);
    /* |angles| */
    mp_allocate_number(mp, &math->md_three_sixty_deg_t, mp_angle_type);
    mp_allocate_number(mp, &math->md_one_eighty_deg_t, mp_angle_type);
    mp_allocate_number(mp, &math->md_negative_one_eighty_deg_t, mp_angle_type);
    /* various approximations */
    mp_allocate_number(mp, &math->md_one_k, mp_scaled_type);
    mp_allocate_number(mp, &math->md_sqrt_8_e_k, mp_scaled_type);
    mp_allocate_number(mp, &math->md_twelve_ln_2_k, mp_fraction_type);
    mp_allocate_number(mp, &math->md_coef_bound_k, mp_fraction_type);
    mp_allocate_number(mp, &math->md_coef_bound_minus_1, mp_fraction_type);
    mp_allocate_number(mp, &math->md_twelvebits_3, mp_scaled_type);
    mp_allocate_number(mp, &math->md_twentysixbits_sqrt2_t, mp_fraction_type);
    mp_allocate_number(mp, &math->md_twentyeightbits_d_t, mp_fraction_type);
    mp_allocate_number(mp, &math->md_twentysevenbits_sqrt2_d_t, mp_fraction_type);
    /* thresholds */
    mp_allocate_number(mp, &math->md_fraction_threshold_t, mp_fraction_type);
    mp_allocate_number(mp, &math->md_half_fraction_threshold_t, mp_fraction_type);
    mp_allocate_number(mp, &math->md_scaled_threshold_t, mp_scaled_type);
    mp_allocate_number(mp, &math->md_half_scaled_threshold_t, mp_scaled_type);
    mp_allocate_number(mp, &math->md_near_zero_angle_t, mp_angle_type);
    mp_allocate_number(mp, &math->md_p_over_v_threshold_t, mp_fraction_type);
    mp_allocate_number(mp, &math->md_equation_threshold_t, mp_scaled_type);
    /* initializations */
    math->md_precision_default.data.pval         = posit_mul(mp_posit_data.d16, mp_posit_data.unity);
    math->md_precision_max.data.pval             = posit_mul(mp_posit_data.d16, mp_posit_data.unity);
    math->md_precision_min.data.pval             = posit_mul(mp_posit_data.d16, mp_posit_data.unity);
    math->md_epsilon_t.data.pval                 = mp_posit_data.epsilon;
    math->md_inf_t.data.pval                     = mp_posit_data.EL_GORDO;
    math->md_negative_inf_t.data.pval            = mp_posit_data.negative_EL_GORDO;
    math->md_one_third_inf_t.data.pval           = mp_posit_data.one_third_EL_GORDO;
    math->md_warning_limit_t.data.pval           = mp_posit_data.warning_limit;
    math->md_unity_t.data.pval                   = mp_posit_data.unity;
    math->md_two_t.data.pval                     = mp_posit_data.two;
    math->md_three_t.data.pval                   = mp_posit_data.three;
    math->md_half_unit_t.data.pval               = mp_posit_data.half_unit;
    math->md_three_quarter_unit_t.data.pval      = mp_posit_data.three_quarter_unit;
    math->md_arc_tol_k.data.pval                 = posit_div(mp_posit_data.unity, mp_posit_data.d4096);                         /* quit when change in arc length estimate reaches this */
    math->md_fraction_one_t.data.pval            = mp_posit_data.fraction_one;
    math->md_fraction_half_t.data.pval           = mp_posit_data.fraction_half;
    math->md_fraction_three_t.data.pval          = mp_posit_data.fraction_three;
    math->md_fraction_four_t.data.pval           = mp_posit_data.fraction_four;
    math->md_three_sixty_deg_t.data.pval         = mp_posit_data.three_sixty_degrees;
    math->md_one_eighty_deg_t.data.pval          = mp_posit_data.one_eighty_degrees;
    math->md_negative_one_eighty_deg_t.data.pval = mp_posit_data.negative_one_eighty_degrees;
    math->md_one_k.data.pval                     = posit_div(mp_posit_data.one, mp_posit_data.d64);
    math->md_sqrt_8_e_k.data.pval                = double_to_posit(1.71552776992141359295);                                /* $2^{16}\sqrt{8/e}  \approx   112428.82793$ */
    math->md_twelve_ln_2_k.data.pval             = posit_mul(double_to_posit(8.31776616671934371292), mp_posit_data.d256); /* $2^{24}\cdot12\ln2 \approx139548959.6165 $ */
    math->md_twelvebits_3.data.pval              = posit_div(integer_to_posit(1365), mp_posit_data.unity);                 /* $1365              \approx 2^{12}/3      $ */
    math->md_twentysixbits_sqrt2_t.data.pval     = posit_div(integer_to_posit(94906266), mp_posit_data.d65536);            /* $2^{26}\sqrt2      \approx 94906265.62   $ */
    math->md_twentyeightbits_d_t.data.pval       = posit_div(integer_to_posit(35596755), mp_posit_data.d65536);            /* $2^{28}d           \approx 35596754.69   $ */
    math->md_twentysevenbits_sqrt2_d_t.data.pval = posit_div(integer_to_posit(25170707), mp_posit_data.d65536);            /* $2^{27}\sqrt2\,d   \approx 25170706.63   $ */
    math->md_coef_bound_k.data.pval              = mp_posit_data.coef_bound;
    math->md_coef_bound_minus_1.data.pval        = posit_sub(mp_posit_data.coef_bound, posit_div(mp_posit_data.one, mp_posit_data.d65536));
    math->md_fraction_threshold_t.data.pval      = double_to_posit(0.04096);                                               /* a |fraction| coefficient less than this is zeroed */
    math->md_half_fraction_threshold_t.data.pval = posit_div(mp_posit_data.fraction_threshold, mp_posit_data.two);
    math->md_scaled_threshold_t.data.pval        = mp_posit_data.scaled_threshold;
    math->md_half_scaled_threshold_t.data.pval   = posit_div(mp_posit_data.scaled_threshold,mp_posit_data.two);
    math->md_near_zero_angle_t.data.pval         = mp_posit_data.near_zero_angle;
    math->md_p_over_v_threshold_t.data.pval      = mp_posit_data.p_over_v_threshold;
    math->md_equation_threshold_t.data.pval      = mp_posit_data.equation_threshold;

    /* functions */
    math->md_from_int                 = mp_set_posit_from_int;
    math->md_from_boolean             = mp_set_posit_from_boolean;
    math->md_from_scaled              = mp_set_posit_from_scaled;
    math->md_from_double              = mp_set_posit_from_double;
    math->md_from_addition            = mp_set_posit_from_addition;
    math->md_half_from_addition       = mp_set_posit_half_from_addition;
    math->md_from_subtraction         = mp_set_posit_from_subtraction;
    math->md_half_from_subtraction    = mp_set_posit_half_from_subtraction;
    math->md_from_oftheway            = mp_set_posit_from_of_the_way;
    math->md_from_div                 = mp_set_posit_from_div;
    math->md_from_mul                 = mp_set_posit_from_mul;
    math->md_from_int_div             = mp_set_posit_from_int_div;
    math->md_from_int_mul             = mp_set_posit_from_int_mul;
    math->md_negate                   = mp_number_negate;
    math->md_add                      = mp_number_add;
    math->md_subtract                 = mp_number_subtract;
    math->md_half                     = mp_number_half;
    math->md_do_double                = mp_number_double;
    math->md_abs                      = mp_posit_abs;
    math->md_clone                    = mp_number_clone;
    math->md_negated_clone            = mp_number_negated_clone;
    math->md_abs_clone                = mp_number_abs_clone;
    math->md_swap                     = mp_number_swap;
    math->md_add_scaled               = mp_number_add_scaled;
    math->md_multiply_int             = mp_number_multiply_int;
    math->md_divide_int               = mp_number_divide_int;
    math->md_to_boolean               = mp_number_to_boolean;
    math->md_to_scaled                = mp_number_to_scaled;
    math->md_to_double                = mp_number_to_double;
    math->md_to_int                   = mp_number_to_int;
    math->md_odd                      = mp_number_odd;
    math->md_equal                    = mp_number_equal;
    math->md_less                     = mp_number_less;
    math->md_greater                  = mp_number_greater;
    math->md_nonequalabs              = mp_number_nonequalabs;
    math->md_round_unscaled           = mp_round_unscaled;
    math->md_floor_scaled             = mp_number_floor;
    math->md_fraction_to_round_scaled = mp_posit_fraction_to_round_scaled;
    math->md_make_scaled              = mp_posit_number_make_scaled;
    math->md_make_fraction            = mp_posit_number_make_fraction;
    math->md_take_fraction            = mp_posit_number_take_fraction;
    math->md_take_scaled              = mp_posit_number_take_scaled;
    math->md_velocity                 = mp_posit_velocity;
    math->md_n_arg                    = mp_posit_n_arg;
    math->md_m_log                    = mp_posit_m_log;
    math->md_m_exp                    = mp_posit_m_exp;
    math->md_m_unif_rand              = mp_posit_m_unif_rand;
    math->md_m_norm_rand              = mp_posit_m_norm_rand;
    math->md_pyth_add                 = mp_posit_pyth_add;
    math->md_pyth_sub                 = mp_posit_pyth_sub;
    math->md_power_of                 = mp_posit_power_of;
    math->md_fraction_to_scaled       = mp_number_fraction_to_scaled;
    math->md_scaled_to_fraction       = mp_number_scaled_to_fraction;
    math->md_scaled_to_angle          = mp_number_scaled_to_angle;
    math->md_angle_to_scaled          = mp_number_angle_to_scaled;
    math->md_init_randoms             = mp_init_randoms;
    math->md_sin_cos                  = mp_posit_sin_cos;
    math->md_slow_add                 = mp_posit_slow_add;
    math->md_sqrt                     = mp_posit_square_rt;
    math->md_print                    = mp_posit_print_number;
    math->md_tostring                 = mp_posit_number_tostring;
    math->md_modulo                   = mp_number_modulo;
    math->md_ab_vs_cd                 = mp_posit_ab_vs_cd;
    math->md_crossing_point           = mp_posit_crossing_point;
    math->md_scan_numeric             = mp_posit_scan_numeric_token;
    math->md_scan_fractional          = mp_posit_scan_fractional_token;
    math->md_free_math                = mp_free_posit_math;
    math->md_set_precision            = mp_posit_set_precision;
    return math;
}

void mp_posit_set_precision (MP mp)
{
    (void) mp;
}

void mp_free_posit_math (MP mp)
{
    /* Is this list up to date? Also check elewhere. */
    mp_free_number(mp, &(mp->math->md_three_sixty_deg_t));
    mp_free_number(mp, &(mp->math->md_one_eighty_deg_t));
    mp_free_number(mp, &(mp->math->md_negative_one_eighty_deg_t));
    mp_free_number(mp, &(mp->math->md_fraction_one_t));
    mp_free_number(mp, &(mp->math->md_zero_t));
    mp_free_number(mp, &(mp->math->md_half_unit_t));
    mp_free_number(mp, &(mp->math->md_three_quarter_unit_t));
    mp_free_number(mp, &(mp->math->md_unity_t));
    mp_free_number(mp, &(mp->math->md_two_t));
    mp_free_number(mp, &(mp->math->md_three_t));
    mp_free_number(mp, &(mp->math->md_one_third_inf_t));
    mp_free_number(mp, &(mp->math->md_inf_t));
    mp_free_number(mp, &(mp->math->md_negative_inf_t));
    mp_free_number(mp, &(mp->math->md_warning_limit_t));
    mp_free_number(mp, &(mp->math->md_one_k));
    mp_free_number(mp, &(mp->math->md_sqrt_8_e_k));
    mp_free_number(mp, &(mp->math->md_twelve_ln_2_k));
    mp_free_number(mp, &(mp->math->md_coef_bound_k));
    mp_free_number(mp, &(mp->math->md_coef_bound_minus_1));
    mp_free_number(mp, &(mp->math->md_fraction_threshold_t));
    mp_free_number(mp, &(mp->math->md_half_fraction_threshold_t));
    mp_free_number(mp, &(mp->math->md_scaled_threshold_t));
    mp_free_number(mp, &(mp->math->md_half_scaled_threshold_t));
    mp_free_number(mp, &(mp->math->md_near_zero_angle_t));
    mp_free_number(mp, &(mp->math->md_p_over_v_threshold_t));
    mp_free_number(mp, &(mp->math->md_equation_threshold_t));
    mp_memory_free(mp->math);
}

@ See mpmathdouble for documentation. @c

void mp_allocate_number (MP mp, mp_number *n, mp_number_type t)
{
    (void) mp;
    n->data.pval = mp_posit_data.zero;
    n->type = t;
}

void mp_allocate_clone (MP mp, mp_number *n, mp_number_type t, mp_number *v)
{
    (void) mp;
    n->type = t;
    n->data.pval = v->data.pval;
}

void mp_allocate_abs (MP mp, mp_number *n, mp_number_type t, mp_number *v)
{
    (void) mp;
    n->type = t;
    n->data.pval = posit_fabs(v->data.pval);
}

void mp_allocate_double (MP mp, mp_number *n, double v)
{
    (void) mp;
    n->type = mp_scaled_type;
    n->data.pval = double_to_posit(v);
}

void mp_free_number (MP mp, mp_number *n)
{
    (void) mp;
    n->type = mp_nan_type;
}

void mp_set_posit_from_int(mp_number *A, int B)
{
    A->data.pval = integer_to_posit(B);
}

void mp_set_posit_from_boolean(mp_number *A, int B)
{
    A->data.pval = integer_to_posit(B);
}

void mp_set_posit_from_scaled(mp_number *A, int B)
{
    A->data.pval = posit_div(integer_to_posit(B), mp_posit_data.d65536);
}

void mp_set_posit_from_double(mp_number *A, double B)
{
    A->data.pval = double_to_posit(B);
}

void mp_set_posit_from_addition(mp_number *A, mp_number *B, mp_number *C)
{
    A->data.pval = posit_add(B->data.pval, C->data.pval);
}

void mp_set_posit_half_from_addition(mp_number *A, mp_number *B, mp_number *C)
{
    A->data.pval = posit_div(posit_add(B->data.pval,C->data.pval), mp_posit_data.two);
}

void mp_set_posit_from_subtraction(mp_number *A, mp_number *B, mp_number *C)
{
    A->data.pval = posit_sub(B->data.pval, C->data.pval);
}

void mp_set_posit_half_from_subtraction(mp_number *A, mp_number *B, mp_number *C)
{
    A->data.pval = posit_div(posit_sub(B->data.pval, C->data.pval), mp_posit_data.two);
}

void mp_set_posit_from_div(mp_number *A, mp_number *B, mp_number *C)
{
    A->data.pval = posit_div(B->data.pval, C->data.pval);
}

void mp_set_posit_from_mul(mp_number *A, mp_number *B, mp_number *C)
{
    A->data.pval = posit_mul(B->data.pval, C->data.pval);
}

void mp_set_posit_from_int_div(mp_number *A, mp_number *B, int C)
{
    A->data.pval = posit_div(B->data.pval, integer_to_posit(C));
}

void mp_set_posit_from_int_mul(mp_number *A, mp_number *B, int C)
{
    A->data.pval = posit_mul(B->data.pval, integer_to_posit(C));
}

void mp_set_posit_from_of_the_way (MP mp, mp_number *A, mp_number *t, mp_number *B, mp_number *C)
{
    (void) mp;
    A->data.pval = posit_sub(B->data.pval, mp_posit_take_fraction(posit_sub(B->data.pval, C->data.pval), t->data.pval));
}

void mp_number_negate(mp_number *A)
{
    A->data.pval = posit_neg(A->data.pval);
}

void mp_number_add(mp_number *A, mp_number *B)
{
    A->data.pval = posit_add(A->data.pval, B->data.pval);
}

void mp_number_subtract(mp_number *A, mp_number *B)
{
    A->data.pval = posit_sub(A->data.pval, B->data.pval);
}

void mp_number_half(mp_number *A)
{
    A->data.pval = posit_div(A->data.pval, mp_posit_data.two);
}

void mp_number_double(mp_number *A)
{
    A->data.pval = posit_mul(A->data.pval, mp_posit_data.two);
}

void mp_number_add_scaled(mp_number *A, int B)
{
    /* also for negative B */
    A->data.pval = posit_add(A->data.pval, posit_div(integer_to_posit(B), mp_posit_data.d65536));
}

void mp_number_multiply_int(mp_number *A, int B)
{
    A->data.pval = posit_mul(A->data.pval, integer_to_posit(B));
}

void mp_number_divide_int(mp_number *A, int B)
{
    A->data.pval = posit_div(A->data.pval, integer_to_posit(B));
}

void mp_posit_abs(mp_number *A)
{
    A->data.pval = posit_fabs(A->data.pval);
}

void mp_number_clone(mp_number *A, mp_number *B)
{
    A->data.pval = B->data.pval;
}

void mp_number_negated_clone(mp_number *A, mp_number *B)
{
    A->data.pval = posit_neg(B->data.pval);
}

void mp_number_abs_clone(mp_number *A, mp_number *B)
{
    A->data.pval = posit_fabs(B->data.pval);
}

void mp_number_swap(mp_number *A, mp_number *B)
{
    posit_t swap_tmp = A->data.pval;
    A->data.pval = B->data.pval;
    B->data.pval = swap_tmp;
}

void mp_number_fraction_to_scaled(mp_number *A)
{
    A->type = mp_scaled_type;
    A->data.pval = posit_div(A->data.pval, mp_posit_data.fraction_multiplier);
}

void mp_number_angle_to_scaled(mp_number *A)
{
    A->type = mp_scaled_type;
    A->data.pval = posit_div(A->data.pval, mp_posit_data.angle_multiplier);
}

void mp_number_scaled_to_fraction(mp_number *A)
{
    A->type = mp_fraction_type;
    A->data.pval = posit_mul(A->data.pval, mp_posit_data.fraction_multiplier);
}

void mp_number_scaled_to_angle(mp_number *A)
{
    A->type = mp_angle_type;
    A->data.pval = posit_mul(A->data.pval, mp_posit_data.angle_multiplier);
}

int mp_number_to_scaled(mp_number *A)
{
    return (int) posit_to_integer(posit_mul(A->data.pval, mp_posit_data.d65536));
}

int mp_number_to_int(mp_number *A)
{
    return (int) posit_to_integer(A->data.pval);
}

int mp_number_to_boolean(mp_number *A)
{
    return posit_eq_zero(A->data.pval) ? 0 : 1;
}

double mp_number_to_double(mp_number *A)
{
    return posit_to_double(A->data.pval);
}

int mp_number_odd(mp_number *A)
{
    return (int) odd(posit_to_integer(A->data.pval));
}

int mp_number_equal(mp_number *A, mp_number *B)
{
    return posit_eq(A->data.pval, B->data.pval);
}

int mp_number_greater(mp_number *A, mp_number *B)
{
    return posit_gt(A->data.pval, B->data.pval);
}

int mp_number_less(mp_number *A, mp_number *B)
{
    return posit_lt(A->data.pval, B->data.pval);
}

int mp_number_nonequalabs(mp_number *A, mp_number *B)
{
    return ! posit_eq(posit_fabs(A->data.pval), posit_fabs(B->data.pval));
}

char *mp_posit_number_tostring (MP mp, mp_number *n)
{
    static char set[64];
    int l = 0;
    char *ret = mp_memory_allocate(64);
    (void) mp;
    snprintf(set, 64, "%.20g", posit_to_double(n->data.pval));
    while (set[l] == ' ') {
        l++;
    }
    strcpy(ret, set+l);
    return ret;
}

void mp_posit_print_number (MP mp, mp_number *n)
{
    char *str = mp_posit_number_tostring(mp, n);
    mp_print_e_str(mp, str);
    mp_memory_free(str);
}

/* Todo: it is hard to overflow posits. Also, we can check zero fast. */

void mp_posit_slow_add (MP mp, mp_number *ret, mp_number *x_orig, mp_number *y_orig)
{
    if (posit_gt(x_orig->data.pval, mp_posit_data.zero)) {
        if (posit_le(y_orig->data.pval, posit_sub(mp_posit_data.EL_GORDO, x_orig->data.pval))) {
            ret->data.pval = posit_add(x_orig->data.pval, y_orig->data.pval);
        } else {
            mp->arith_error = 1;
            ret->data.pval = mp_posit_data.EL_GORDO;
        }
    } else if (posit_le(posit_neg(y_orig->data.pval), posit_add(mp_posit_data.EL_GORDO, x_orig->data.pval))) {
        ret->data.pval = posit_add(x_orig->data.pval, y_orig->data.pval);
    } else {
        mp->arith_error = 1;
        ret->data.pval = mp_posit_data.negative_EL_GORDO;
    }
}

void mp_posit_number_make_fraction (MP mp, mp_number *ret, mp_number *p, mp_number *q) {
    (void) mp;
    ret->data.pval = mp_posit_make_fraction(p->data.pval, q->data.pval);
}

void mp_posit_number_take_fraction (MP mp, mp_number *ret, mp_number *p, mp_number *q) {
   (void) mp;
   ret->data.pval = mp_posit_take_fraction(p->data.pval, q->data.pval);
}

void mp_posit_number_take_scaled (MP mp, mp_number *ret, mp_number *p_orig, mp_number *q_orig)
{
    (void) mp;
    ret->data.pval = posit_mul(p_orig->data.pval, q_orig->data.pval);
}

void mp_posit_number_make_scaled (MP mp, mp_number *ret, mp_number *p_orig, mp_number *q_orig)
{
    (void) mp;
    ret->data.pval = posit_div(p_orig->data.pval, q_orig->data.pval);
}

void mp_wrapup_numeric_token (MP mp, unsigned char *start, unsigned char *stop)
{
    double result;
    char *end = (char *) stop;
    errno = 0;
    result = strtod((char *) start, &end);
    if (errno == 0) {
        set_cur_mod(double_to_posit(result));
        if (result >= mp_warning_limit) {
            if (posit_gt(internal_value(mp_warning_check_internal).data.pval, mp_posit_data.zero) && (mp->scanner_status != mp_tex_flushing_state)) {
                char msg[256];
                mp_snprintf(msg, 256, "Number is too large (%g)", result);
                @.Number is too large@>
                mp_error(
                    mp,
                    msg,
                    "Continue and I'll try to cope with that big value; but it might be dangerous."
                    "(Set warningcheck := 0 to suppress this message.)"
                );
            }
        }
    } else if (mp->scanner_status != mp_tex_flushing_state) {
        mp_error(
            mp,
            "Enormous number has been reduced.",
            "I could not handle this number specification probably because it is out of"
            "range."
        );
        @.Enormous number...@>
        set_cur_mod(mp_posit_data.EL_GORDO);
    }
    set_cur_cmd(mp_numeric_command);
}

static void mp_posit_aux_find_exponent (MP mp)
{
    if (mp->buffer[mp->cur_input.loc_field] == 'e' || mp->buffer[mp->cur_input.loc_field] == 'E') {
        mp->cur_input.loc_field++;
        if (!(mp->buffer[mp->cur_input.loc_field] == '+'
           || mp->buffer[mp->cur_input.loc_field] == '-'
           || mp->char_class[mp->buffer[mp->cur_input.loc_field]] == mp_digit_class)) {
            mp->cur_input.loc_field--;
            return;
        }
        if (mp->buffer[mp->cur_input.loc_field] == '+'
         || mp->buffer[mp->cur_input.loc_field] == '-') {
            mp->cur_input.loc_field++;
        }
        while (mp->char_class[mp->buffer[mp->cur_input.loc_field]] == mp_digit_class) {
            mp->cur_input.loc_field++;
        }
    }
}

void mp_posit_scan_fractional_token (MP mp, int n) /* n is scaled */
{
    unsigned char *start = &mp->buffer[mp->cur_input.loc_field -1];
    unsigned char *stop;
    (void) n;
    while (mp->char_class[mp->buffer[mp->cur_input.loc_field]] == mp_digit_class) {
        mp->cur_input.loc_field++;
    }
    mp_posit_aux_find_exponent(mp);
    stop = &mp->buffer[mp->cur_input.loc_field-1];
    mp_wrapup_numeric_token(mp, start, stop);
}

void mp_posit_scan_numeric_token (MP mp, int n) /* n is scaled */
{
    unsigned char *start = &mp->buffer[mp->cur_input.loc_field -1];
    unsigned char *stop;
    (void) n;
    while (mp->char_class[mp->buffer[mp->cur_input.loc_field]] == mp_digit_class) {
        mp->cur_input.loc_field++;
    }
    if (mp->buffer[mp->cur_input.loc_field] == '.' && mp->buffer[mp->cur_input.loc_field+1] != '.') {
        mp->cur_input.loc_field++;
        while (mp->char_class[mp->buffer[mp->cur_input.loc_field]] == mp_digit_class) {
            mp->cur_input.loc_field++;
        }
    }
    mp_posit_aux_find_exponent(mp);
    stop = &mp->buffer[mp->cur_input.loc_field-1];
    mp_wrapup_numeric_token(mp, start, stop);
}

void mp_posit_velocity (MP mp, mp_number *ret, mp_number *st, mp_number *ct, mp_number *sf, mp_number *cf, mp_number *t)
{
    posit_t acc, num, denom; /* registers for intermediate calculations */
    (void) mp;
    acc = mp_posit_take_fraction(
        mp_posit_take_fraction(
            posit_sub(st->data.pval, posit_div(sf->data.pval, mp_posit_data.sixteen)),
            posit_sub(sf->data.pval, posit_div(st->data.pval, mp_posit_data.sixteen))
        ),
        posit_sub(ct->data.pval,cf->data.pval)
    );
    num = posit_add(
        mp_posit_data.fraction_two,
        mp_posit_take_fraction(
            acc,
            mp_posit_data.sqrt_two_mul_fraction_one
        )
    );
    denom = posit_add(
        mp_posit_data.fraction_three,
        posit_add(
            mp_posit_take_fraction(
                ct->data.pval,
                mp_posit_data.sqrt_five_minus_one_mul_fraction_one_and_half
            ),
            mp_posit_take_fraction(
                cf->data.pval,
                mp_posit_data.three_minus_sqrt_five_mul_fraction_one_and_half
            )
        )
    );
    if (posit_ne(t->data.pval, mp_posit_data.unity)) {
        num = mp_posit_make_scaled(num, t->data.pval);
    }
    if (posit_ge(posit_div(num, mp_posit_data.four), denom)) {
        ret->data.pval = mp_posit_data.fraction_four;
    } else {
        ret->data.pval = mp_posit_make_fraction(num, denom);
    }
}

int mp_posit_ab_vs_cd (mp_number *a_orig, mp_number *b_orig, mp_number *c_orig, mp_number *d_orig)
{
    posit_t ab = posit_mul(a_orig->data.pval, b_orig->data.pval);
    posit_t cd = posit_mul(c_orig->data.pval, d_orig->data.pval);
    if (posit_eq(ab,cd)) {
        return 0;
    } else if (posit_lt(ab,cd)) {
        return -1;
    } else {
        return 1;
    }
}

static void mp_posit_crossing_point (MP mp, mp_number *ret, mp_number *aa, mp_number *bb, mp_number *cc)
{
    posit_t d;
    posit_t xx, x0, x1, x2;
    posit_t a = aa->data.pval;
    posit_t b = bb->data.pval;
    posit_t c = cc->data.pval;
    (void) mp;
    if (posit_lt(a, mp_posit_data.zero)) {
        ret->data.pval = mp_posit_data.zero_crossing;
        return;
    }
    if (posit_ge(c, mp_posit_data.zero)) {
        if (posit_ge(b, mp_posit_data.zero)) {
            if (posit_gt(c, mp_posit_data.zero)) {
                ret->data.pval = mp_posit_data.no_crossing;
            } else if (posit_eq_zero(a) && posit_eq_zero(b)) {
                ret->data.pval = mp_posit_data.no_crossing;
            } else {
                ret->data.pval = mp_posit_data.one_crossing;
            }
            return;
        }
        if (posit_eq_zero(a)) {
            ret->data.pval = mp_posit_data.zero_crossing;
            return;
        }
    } else if (posit_eq_zero(a) && posit_le(b, mp_posit_data.zero)) {
        ret->data.pval = mp_posit_data.zero_crossing;
        return;
    }
    /* Use bisection to find the crossing point... */
    d = mp_posit_data.epsilon;
    x0 = a;
    x1 = posit_sub(a, b);
    x2 = posit_sub(b, c);
    do {
        /* not sure why the error correction has to be >= 1E-12 */
        posit_t x = posit_add(posit_div(posit_add(x1, x2), mp_posit_data.two), mp_posit_data.error_correction);
        if (posit_gt(posit_sub(x1, x0), x0)) {
            x2 = x;
            x0 = posit_add(x0, x0);
            d = posit_add(d, d);
        } else {
            xx = posit_sub(posit_add(x1, x), x0);
            if (posit_gt(xx, x0)) {
                x2 = x;
                x0 = posit_add(x0, x0);
                d = posit_add(d, d);
            } else {
                x0 = posit_sub(x0, xx);
                if (posit_le(x, x0) && posit_le(posit_add(x, x2), x0)) {
                    ret->data.pval = mp_posit_data.no_crossing;
                    return;
                }
                x1 = x;
                d = posit_add(posit_add(d, d), mp_posit_data.epsilon);
            }
        }
    } while (posit_lt(d, mp_posit_data.fraction_one));
    ret->data.pval = posit_sub(d, mp_posit_data.fraction_one);
}

@ See mpmathdouble for documentation. @c

int mp_round_unscaled(mp_number *x_orig)
{
    return posit_i_round(x_orig->data.pval);
}

void mp_number_floor(mp_number *i)
{
    i->data.pval = posit_floor(i->data.pval);
}

void mp_posit_fraction_to_round_scaled(mp_number *x_orig)
{
    x_orig->type = mp_scaled_type;
    x_orig->data.pval = posit_div(x_orig->data.pval, mp_posit_data.fraction_multiplier);
}

void mp_posit_square_rt (MP mp, mp_number *ret, mp_number *x_orig) /* return, x: scaled */
{
    if (posit_gt(x_orig->data.pval, mp_posit_data.zero)) {
        ret->data.pval = posit_sqrt(x_orig->data.pval);
    } else {
        if (posit_lt(x_orig->data.pval, mp_posit_data.zero)) {
            char msg[256];
            char *xstr = mp_posit_number_tostring(mp, x_orig);
            mp_snprintf(msg, 256, "Square root of %s has been replaced by 0", xstr);
            mp_memory_free(xstr);
            @.Square root...replaced by 0@>
            mp_error(
                mp,
                msg,
                "Since I don't take square roots of negative numbers, I'm zeroing this one.\n"
                "Proceed, with fingers crossed."
            );
        }
        ret->data.pval = mp_posit_data.zero;
    }
}

void mp_posit_pyth_add (MP mp, mp_number *ret, mp_number *a_orig, mp_number *b_orig)
{
    (void) mp;
    ret->data.pval = posit_sqrt(
        posit_add(
            posit_mul(
                a_orig->data.pval,
                a_orig->data.pval
            ),
            posit_mul(
                b_orig->data.pval,
                b_orig->data.pval
            )
        )
    );
}

void mp_posit_pyth_sub (MP mp, mp_number *ret, mp_number *a_orig, mp_number *b_orig)
{
    /* can be made nicer */
    if (posit_gt(a_orig->data.pval,b_orig->data.pval)) {
        a_orig->data.pval = posit_sqrt(
            posit_sub(
                posit_mul(
                    a_orig->data.pval,
                    a_orig->data.pval
                ),
                posit_mul(
                    b_orig->data.pval,
                    b_orig->data.pval
                )
            )
        );
    } else {
        if (posit_lt(a_orig->data.pval,b_orig->data.pval)) {
            char msg[256];
            char *astr = mp_posit_number_tostring(mp, a_orig);
            char *bstr = mp_posit_number_tostring(mp, b_orig);
            mp_snprintf(msg, 256, "Pythagorean subtraction %s+-+%s has been replaced by 0", astr, bstr);
            mp_memory_free(astr);
            mp_memory_free(bstr);
            @.Pythagorean...@>
            mp_error(
                mp,
                msg,
                "Since I don't take square roots of negative numbers, Im zeroing this one.\n"
                "Proceed, with fingers crossed."
            );
        }
        a_orig->data.pval = mp_posit_data.zero;
    }
    ret->data.pval = a_orig->data.pval;
}

void mp_posit_power_of (MP mp, mp_number *ret, mp_number *a_orig, mp_number *b_orig)
{
    errno = 0;
    ret->data.pval = posit_pow(a_orig->data.pval, b_orig->data.pval);
    if (errno) {
        mp->arith_error = 1;
        ret->data.pval = mp_posit_data.EL_GORDO;
    }
}

void mp_posit_m_log (MP mp, mp_number *ret, mp_number *x_orig)
{
    /* TODO: int mult */
    if (posit_gt(x_orig->data.pval,mp_posit_data.zero)) {
        ret->data.pval = posit_mul(posit_log(x_orig->data.pval),mp_posit_data.d256);
    } else {
        char msg[256];
        char *xstr = mp_posit_number_tostring(mp, x_orig);
        mp_snprintf(msg, 256, "Logarithm of %s has been replaced by 0", xstr);
        mp_memory_free(xstr);
        mp_error(
            mp,
            msg,
            "Since I don't take logs of non-positive numbers, I'm zeroing this one.\n"
            "Proceed, with fingers crossed."
        );
        ret->data.pval = mp_posit_data.zero;
    }
}

void mp_posit_m_exp (MP mp, mp_number *ret, mp_number *x_orig)
{
    errno = 0;
    ret->data.pval = posit_exp(posit_div(x_orig->data.pval,mp_posit_data.d256));
    if (errno) {
        if (posit_gt(x_orig->data.pval,mp_posit_data.zero)) {
            mp->arith_error = 1;
            ret->data.pval = mp_posit_data.EL_GORDO;
        } else {
            ret->data.pval = mp_posit_data.zero;
        }
    }
}

void mp_posit_n_arg (MP mp, mp_number *ret, mp_number *x_orig, mp_number *y_orig)
{
    if (posit_eq_zero(x_orig->data.pval) && posit_eq_zero(y_orig->data.pval)) {
        mp_error(
            mp,
            "angle(0,0) is taken as zero",
            "The 'angle' between two identical points is undefined. I'm zeroing this one.\n"
            "Proceed, with fingers crossed."
        );
        ret->data.pval = mp_posit_data.zero;
    } else {
        ret->type = mp_angle_type;
        /* TODO */
        ret->data.pval = posit_mul(
            posit_atan2(
                y_orig->data.pval,
                x_orig->data.pval
            ),
            mp_posit_data.d180_divided_by_pi_mul_angle
        );
    }
}

void mp_posit_sin_cos (MP mp, mp_number *z_orig, mp_number *n_cos, mp_number *n_sin)
{
    posit_t rad = posit_div(z_orig->data.pval, mp_posit_data.angle_multiplier);
    (void) mp;
    if (posit_eq(rad, mp_posit_data.dp90) || posit_eq(rad, mp_posit_data.dm270)) {
        n_cos->data.pval = mp_posit_data.zero;
        n_sin->data.pval = mp_posit_data.fraction_multiplier;
    } else if (posit_eq(rad, mp_posit_data.dm90) || posit_eq(rad, mp_posit_data.dp270)) {
        n_cos->data.pval = mp_posit_data.zero;
        n_sin->data.pval = mp_posit_data.negative_fraction_multiplier;
    } else if (posit_eq(rad, mp_posit_data.dp180) || posit_eq(rad, mp_posit_data.dm180)) {
        n_cos->data.pval = mp_posit_data.negative_fraction_multiplier;
        n_sin->data.pval = mp_posit_data.zero;
    } else {
        rad = posit_mul(rad,mp_posit_data.pi_divided_by_180);
        n_cos->data.pval = posit_mul(posit_cos(rad),mp_posit_data.fraction_multiplier);
        n_sin->data.pval = posit_mul(posit_sin(rad),mp_posit_data.fraction_multiplier);
    }
}

@ See mpmathdouble for documentation. @c

# define KK            100                /* the long lag  */
# define LL            37                 /* the short lag */
# define MM            (1L<<30)           /* the modulus   */
# define mod_diff(x,y) (((x)-(y))&(MM-1)) /* subtraction mod MM */
# define TT            70                 /* guaranteed separation between streams */
# define is_odd(x)     ((x)&1)            /* units bit of x */
# define QUALITY       1009               /* recommended quality level for high-res use */

/* destination, array length (must be at least KK) */

typedef struct mp_posit_random_info {
    long  x[KK];
    long  buf[QUALITY];
    long  dummy;
    long  started;
    long *ptr;
} mp_posit_random_info;

static mp_posit_random_info mp_posit_random_data = {
    .dummy   = -1,
    .started = -1,
    .ptr     = &mp_posit_random_data.dummy
};

/* the following routines are from exercise 3.6--15 */
/* after calling |mp_aux_ran_start|, get new randoms by, e.g., |x=mp_aux_ran_arr_next()| */

static void mp_posit_aux_ran_array(long aa[], int n)
{
    int i, j;
    for (j = 0; j < KK; j++) {
        aa[j] = mp_posit_random_data.x[j];
    }
    for (; j < n; j++) {
        aa[j] = mod_diff(aa[j - KK], aa[j - LL]);
    }
    for (i = 0; i < LL; i++, j++) {
        mp_posit_random_data.x[i] = mod_diff(aa[j - KK], aa[j - LL]);
    }
    for (; i < KK; i++, j++) {
        mp_posit_random_data.x[i] = mod_diff(aa[j - KK], mp_posit_random_data.x[i - LL]);
    }
}

/* Do this before using |mp_aux_ran_array|, long seed selector for different streams. */

static void mp_posit_aux_ran_start(long seed)
{
    int t, j;
    long x[KK + KK - 1]; /* the preparation buffer */
    long ss = (seed+2) & (MM - 2);
    for (j = 0; j < KK; j++) {
        /* bootstrap the buffer */
        x[j] = ss;
        /* cyclic shift 29 bits */
        ss <<= 1;
        if (ss >= MM) {
            ss -= MM - 2;
        }
    }
    /* make x[1] (and only x[1]) odd */
    x[1]++;
    for (ss = seed & (MM - 1), t = TT - 1; t;) {
        for (j = KK - 1; j > 0; j--) {
            /* "square" */
            x[j + j] = x[j];
            x[j + j - 1] = 0;
        }
        for (j = KK + KK - 2; j >= KK; j--) {
            x[j - (KK -LL)] = mod_diff(x[j - (KK - LL)], x[j]);
            x[j - KK] = mod_diff(x[j - KK], x[j]);
        }
        if (is_odd(ss)) {
            /* "multiply by z" */
            for (j = KK; j>0; j--) {
                x[j] = x[j-1];
            }
            x[0] = x[KK];
            /* shift the buffer cyclically */
            x[LL] = mod_diff(x[LL], x[KK]);
        }
        if (ss) {
            ss >>= 1;
        } else {
            t--;
        }
    }
    for (j = 0; j < LL; j++) {
        mp_posit_random_data.x[j + KK - LL] = x[j];
    }
    for (;j < KK; j++) {
        mp_posit_random_data.x[j - LL] = x[j];
    }
    for (j = 0; j < 10; j++) {
        /* warm things up */
        mp_posit_aux_ran_array(x, KK + KK - 1);
    }
    mp_posit_random_data.ptr = &mp_posit_random_data.started;
}

static long mp_posit_aux_ran_arr_cycle(void)
{
    if (mp_posit_random_data.ptr == &mp_posit_random_data.dummy) {
        /* the user forgot to initialize */
        mp_posit_aux_ran_start(314159L);
    }
    mp_posit_aux_ran_array(mp_posit_random_data.buf, QUALITY);
    mp_posit_random_data.buf[KK] = -1;
    mp_posit_random_data.ptr = mp_posit_random_data.buf + 1;
    return mp_posit_random_data.buf[0];
}

void mp_init_randoms (MP mp, int seed)
{
    int k = 1;
    int j = abs(seed);
    int f = (int) mp_fraction_multiplier; /* avoid warnings */
    while (j >= f) {
        j = j/2;
    }
    for (int i = 0; i <= 54; i++) {
        int jj = k;
        k = j - k;
        j = jj;
        if (k < 0) {
            k += f;
        }
        mp->randoms[(i * 21) % 55].data.pval = integer_to_posit(j);
    }
    mp_new_randoms(mp);
    mp_new_randoms(mp);
    mp_new_randoms(mp);
    /* warm up the array */
    mp_posit_aux_ran_start((unsigned long) seed);
}

void mp_number_modulo(mp_number *a, mp_number *b)
{
    a->data.pval = posit_mul(posit_modf(posit_div(a->data.pval, b->data.pval)), b->data.pval);
}

static void mp_next_unif_random (MP mp, mp_number *ret)
{
    unsigned long int op = (unsigned) (*mp_posit_random_data.ptr >=0 ? *mp_posit_random_data.ptr++: mp_posit_aux_ran_arr_cycle());
    double a = op / (MM * 1.0);
    (void) mp;
    ret->data.pval = double_to_posit(a);
}

static void mp_next_random (MP mp, mp_number *ret)
{
    if ( mp->j_random==0) {
        mp_new_randoms(mp);
    } else {
        mp->j_random = mp->j_random-1;
    }
    mp_number_clone(ret, &(mp->randoms[mp->j_random]));
}

static void mp_posit_m_unif_rand (MP mp, mp_number *ret, mp_number *x_orig)
{
    mp_number x, abs_x, u, y;
    mp_allocate_number(mp, &y, mp_fraction_type);
    mp_allocate_clone(mp, &x, mp_scaled_type, x_orig);
    mp_allocate_abs(mp, &abs_x, mp_scaled_type, &x);
    mp_allocate_number(mp, &u, mp_scaled_type);
    mp_next_unif_random(mp, &u);
    y.data.pval = posit_mul(abs_x.data.pval, u.data.pval);
    mp_free_number(mp, &u);
    if (mp_number_equal(&y, &abs_x)) {
        mp_number_clone(ret, &((math_data *)mp->math)->md_zero_t);
    } else if (mp_number_greater(&x, &((math_data *)mp->math)->md_zero_t)) {
        mp_number_clone(ret, &y);
    } else {
        mp_number_negated_clone(ret, &y);
    }
    mp_free_number(mp, &abs_x);
    mp_free_number(mp, &x);
    mp_free_number(mp, &y);
}

static void mp_posit_m_norm_rand (MP mp, mp_number *ret)
{
    mp_number abs_x, u, r, la, xa;
    mp_allocate_number(mp, &la, mp_scaled_type);
    mp_allocate_number(mp, &xa, mp_scaled_type);
    mp_allocate_number(mp, &abs_x, mp_scaled_type);
    mp_allocate_number(mp, &u, mp_scaled_type);
    mp_allocate_number(mp, &r, mp_scaled_type);
    do {
        do {
            mp_number v;
            mp_allocate_number(mp, &v, mp_scaled_type);
            mp_next_random(mp, &v);
            mp_number_subtract(&v, &((math_data *)mp->math)->md_fraction_half_t);
            mp_posit_number_take_fraction(mp, &xa, &((math_data *)mp->math)->md_sqrt_8_e_k, &v);
            mp_free_number(mp, &v);
            mp_next_random(mp, &u);
            mp_number_clone(&abs_x, &xa);
            mp_posit_abs(&abs_x);
        } while (! mp_number_less(&abs_x, &u));
        mp_posit_number_make_fraction(mp, &r, &xa, &u);
        mp_number_clone(&xa, &r);
        mp_posit_m_log(mp, &la, &u);
        mp_set_posit_from_subtraction(&la, &((math_data *)mp->math)->md_twelve_ln_2_k, &la);
    } while (mp_posit_ab_vs_cd(&((math_data *)mp->math)->md_one_k, &la, &xa, &xa) < 0);
    mp_number_clone(ret, &xa);
    mp_free_number(mp, &r);
    mp_free_number(mp, &abs_x);
    mp_free_number(mp, &la);
    mp_free_number(mp, &xa);
    mp_free_number(mp, &u);
}

@ @<Reduce to the case that |a...@>=
if (posit_lt(a, mp_posit_data.zero)) {
    a = posit_neg(a);
    b = posit_neg(b);
}
if (posit_lt(c, mp_posit_data.zero)) {
    c = posit_neg(c);
    d = posit_neg(d);
}
if ((posit_le(d, mp_posit_data.zero)) {
    if ((posit_ge(b, mp_posit_data.zero)) {
        if ((posit_eq_zero(a) || posit_eq_zero(b) && (posit_eq_zero(c) || posit_eq_zero(d))) {
            ret->data.pval = mp_posit_data.zero;
        } else {
            ret->data.pval = mp_posit_data.one;
        }
        goto RETURN;
    } if (posit_eq_zero(d)) {
        ret->data.pval = posit_eq_zero(a) ? mp_posit_data.zero : mp_posit_data.minusone;
        goto RETURN;
    } else
        q = a;
        a = c;
        c = q;
        q = -b;
        b = -d;
        d = q;
    }
} else if (posit_le(b, mp_posit_data.zero) {
    if (posit_lt(b, mp_posit_data.zero) && posit_gt(a, mp_posit_data.zero)) {
        ret->data.pval = mp_posit_data.minusone;
        return;
    } else
        ret->data.pval = posit_eq_zero(c) ? mp_posit_data.zero : mp_posit_data.minusone;
        goto RETURN;
    }
}