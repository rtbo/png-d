module libpng.png;

import libpng.conf;
import libpng.libconf;

extern(C) nothrow @nogc:

static if (PNG_STDIO_SUPPORTED) {
    import core.stdc.stdio : FILE;
}
static if (PNG_SETJMP_SUPPORTED) {
    version(Posix) {
        import core.sys.posix.setjmp : jmp_buf;
    }
    version(Windows) {
        // setjmp?
    }
}
static if (PNG_tIME_SUPPORTED) {
    import core.stdc.time : time_t, tm;
}

enum PNG_LIBPNG_VER_STRING = "1.6.35";
enum PNG_HEADER_VERSION_STRING = " libpng version 1.6.35 - July 15, 2018\n";

enum PNG_LIBPNG_VER_SONUM = 16;
enum PNG_LIBPNG_VER_DLLNUM = 16;

enum PNG_LIBPNG_VER_MAJOR = 1;
enum PNG_LIBPNG_VER_MINOR = 6;
enum PNG_LIBPNG_VER_RELEASE = 35;

enum PNG_LIBPNG_VER = 10635; // 1.6.35

extern(D)
auto png_libpng_ver()
{
    return png_get_header_ver(null);
}

/* This file is arranged in several sections:
 *
 * 1. [omitted]
 * 2. Any configuration options that can be specified by for the application
 *    code when it is built.  (Build time configuration is in pnglibconf.h)
 * 3. Type definitions (base types are defined in pngconf.h), structure
 *    definitions.
 * 4. Exported library functions.
 * 5. Simplified API.
 * 6. Implementation options.
 *
 * The library source code has additional files (principally pngpriv.h) that
 * allow configuration of the library.
 */

/* Section 2: run time configuration
 * See pnglibconf.h for build time configuration
 *
 * Run time configuration allows the application to choose between
 * implementations of certain arithmetic APIs.  The default is set
 * at build time and recorded in pnglibconf.h, but it is safe to
 * override these (and only these) settings.  Note that this won't
 * change what the library does, only application code, and the
 * settings can (and probably should) be made on a per-file basis
 * by setting the #defines before including png.h
 *
 * Use macros to read integers from PNG data or use the exported
 * functions?
 *   PNG_USE_READ_MACROS: use the macros (see below)  Note that
 *     the macros evaluate their argument multiple times.
 *   PNG_NO_USE_READ_MACROS: call the relevant library function.
 *
 * Use the alternative algorithm for compositing alpha samples that
 * does not use division?
 *   PNG_READ_COMPOSITE_NODIV_SUPPORTED: use the 'no division'
 *      algorithm.
 *   PNG_NO_READ_COMPOSITE_NODIV: use the 'division' algorithm.
 *
 * How to handle benign errors if PNG_ALLOW_BENIGN_ERRORS is
 * false?
 *   PNG_ALLOW_BENIGN_ERRORS: map calls to the benign error
 *      APIs to png_warning.
 * Otherwise the calls are mapped to png_error.
 */

/* Section 3: type definitions, including structures and compile time
 * constants.
 * See pngconf.h for base types that vary by machine/system
 */

struct png_struct;
alias png_const_structp = const(png_struct)*;
alias png_structp = png_struct*;
alias png_structpp = png_struct**;

alias png_structrp = png_structp;
alias png_const_structrp = png_const_structp;

struct png_info;
alias png_const_infop = const(png_info)*;
alias png_infop = png_info*;
alias png_infopp = png_info**;

alias png_inforp = png_infop;
alias png_const_inforp = png_const_infop;

struct png_color
{
   png_byte red;
   png_byte green;
   png_byte blue;
}
alias png_colorp = png_color*;
alias png_const_colorp = const(png_color)*;
alias png_colorpp = png_color**;

struct png_color_16
{
   png_byte index;    /* used for palette files */
   png_uint_16 red;   /* for use in red green blue files */
   png_uint_16 green;
   png_uint_16 blue;
   png_uint_16 gray;  /* for use in grayscale files */
}
alias png_color_16p = png_color_16*;
alias png_const_color_16p = const(png_color_16)*;
alias png_color_16pp = png_color_16**;

struct png_color_8
{
   png_byte red;   /* for use in red green blue files */
   png_byte green;
   png_byte blue;
   png_byte gray;  /* for use in grayscale files */
   png_byte alpha; /* for alpha channel files */
}
alias png_color_8p = png_color_8*;
alias png_const_color_8p = const(png_color_8)*;
alias png_color_8pp = png_color_8**;

struct png_sPLT_entry
{
   png_uint_16 red;
   png_uint_16 green;
   png_uint_16 blue;
   png_uint_16 alpha;
   png_uint_16 frequency;
}
alias png_sPLT_entryp = png_sPLT_entry*;
alias png_const_sPLT_entryp = const(png_sPLT_entry)*;
alias png_sPLT_entrypp = png_sPLT_entry**;

struct png_sPLT_t
{
   png_charp name;           /* palette name */
   png_byte depth;           /* depth of palette samples */
   png_sPLT_entryp entries;  /* palette entries */
   png_int_32 nentries;      /* number of palette entries */
}
alias png_sPLT_tp = png_sPLT_t*;
alias png_const_sPLT_tp = const(png_sPLT_t)*;
alias png_sPLT_tpp = png_sPLT_t**;

static if (PNG_TEXT_SUPPORTED) {

    struct png_text
    {
        int  compression;       /* compression value:
                                    -1: tEXt, none
                                    0: zTXt, deflate
                                    1: iTXt, none
                                    2: iTXt, deflate  */
        png_charp key;          /* keyword, 1-79 character description of "text" */
        png_charp text;         /* comment, may be an empty string (ie "")
                                    or a NULL pointer */
        size_t text_length;     /* length of the text string */
        size_t itxt_length;     /* length of the itxt string */
        png_charp lang;         /* language code, 0-79 characters
                                    or a NULL pointer */
        png_charp lang_key;     /* keyword translated UTF-8 string, 0 or more
                                    chars or a NULL pointer */
    }
    alias png_textp = png_text*;
    alias png_const_textp = const(png_text)*;
    alias png_textpp = png_text**;
}

enum PNG_TEXT_COMPRESSION_NONE_WR = -3;
enum PNG_TEXT_COMPRESSION_zTXt_WR = -2;
enum PNG_TEXT_COMPRESSION_NONE = -1;
enum PNG_TEXT_COMPRESSION_zTXt = 0;
enum PNG_ITXT_COMPRESSION_NONE = 1;
enum PNG_ITXT_COMPRESSION_zTXt = 2;
enum PNG_TEXT_COMPRESSION_LAST = 3;

struct png_time
{
   png_uint_16 year; /* full year, as in, 1995 */
   png_byte month;   /* month of year, 1 - 12 */
   png_byte day;     /* day of month, 1 - 31 */
   png_byte hour;    /* hour of day, 0 - 23 */
   png_byte minute;  /* minute of hour, 0 - 59 */
   png_byte second;  /* second of minute, 0 - 60 (for leap seconds) */
}
alias png_timep = png_time*;
alias png_const_timep = const(png_time)*;
alias png_timepp = png_time**;

static if (PNG_STORE_UNKNOWN_CHUNKS_SUPPORTED || PNG_USER_CHUNKS_SUPPORTED) {

    struct png_unknown_chunk
    {
        png_byte[5] name; /* Textual chunk name with '\0' terminator */
        png_byte *data;   /* Data, should not be modified on read! */
        size_t size;

        png_byte location; /* mode of operation at read time */
    }
    alias png_unknown_chunkp = png_unknown_chunk*;
    alias png_const_unknown_chunkp = const(png_unknown_chunk)*;
    alias png_unknown_chunkpp = png_unknown_chunk**;

}

enum PNG_HAVE_IHDR = 0x01;
enum PNG_HAVE_PLTE = 0x02;
enum PNG_AFTER_IDAT = 0x08;

enum uint PNG_UINT_31_MAX = 0x7fffffffL;
enum uint PNG_UINT_32_MAX = uint.max;
enum size_t PNG_SIZE_MAX = size_t.max;

enum png_fixed_point PNG_FP_1 = 100000;
enum png_fixed_point PNG_FP_HALF = 50000;
enum png_fixed_point PNG_FP_MAX = 0x7fffffff;
enum png_fixed_point PNG_FP_MIN = -PNG_FP_MAX;

enum PNG_COLOR_MASK_PALETTE = 1;
enum PNG_COLOR_MASK_COLOR = 2;
enum PNG_COLOR_MASK_ALPHA = 4;

enum PNG_COLOR_TYPE_GRAY = 0;
enum PNG_COLOR_TYPE_PALETTE     = PNG_COLOR_MASK_COLOR | PNG_COLOR_MASK_PALETTE;
enum PNG_COLOR_TYPE_RGB         = PNG_COLOR_MASK_COLOR;
enum PNG_COLOR_TYPE_RGB_ALPHA   = PNG_COLOR_MASK_COLOR | PNG_COLOR_MASK_ALPHA;
enum PNG_COLOR_TYPE_GRAY_ALPHA  = PNG_COLOR_MASK_ALPHA;

enum PNG_COLOR_TYPE_RGBA        = PNG_COLOR_TYPE_RGB_ALPHA;
enum PNG_COLOR_TYPE_GA          = PNG_COLOR_TYPE_GRAY_ALPHA;

enum PNG_COMPRESSION_TYPE_BASE = 0;
enum PNG_COMPRESSION_TYPE_DEFAULT = PNG_COMPRESSION_TYPE_BASE;

enum PNG_FILTER_TYPE_BASE = 0;
enum PNG_INTRAPIXEL_DIFFERENCING = 64;
enum PNG_FILTER_TYPE_DEFAULT = PNG_FILTER_TYPE_BASE;

enum PNG_INTERLACE_NONE = 0;
enum PNG_INTERLACE_ADAM7 = 1;
enum PNG_INTERLACE_LAST = 2;

enum PNG_OFFSET_PIXEL = 0;
enum PNG_OFFSET_MICROMETER = 1;
enum PNG_OFFSET_LAST = 2;

enum PNG_EQUATION_LINEAR = 0;
enum PNG_EQUATION_BASE_E = 1;
enum PNG_EQUATION_ARBITRARY = 2;
enum PNG_EQUATION_HYPERBOLIC = 3;
enum PNG_EQUATION_LAST = 4;

enum PNG_SCALE_UNKNOWN = 0;
enum PNG_SCALE_METER = 1;
enum PNG_SCALE_RADIAN = 2;
enum PNG_SCALE_LAST = 3;

enum PNG_RESOLUTION_UNKNOWN = 0;
enum PNG_RESOLUTION_METER = 1;
enum PNG_RESOLUTION_LAST = 2;

enum PNG_sRGB_INTENT_PERCEPTUAL = 0;
enum PNG_sRGB_INTENT_RELATIVE = 1;
enum PNG_sRGB_INTENT_SATURATION = 2;
enum PNG_sRGB_INTENT_ABSOLUTE = 3;
enum PNG_sRGB_INTENT_LAST = 4;

enum PNG_KEYWORD_MAX_LENGTH = 79;

enum PNG_MAX_PALETTE_LENGTH = 256;

enum PNG_INFO_gAMA = 0x0001U;
enum PNG_INFO_sBIT = 0x0002U;
enum PNG_INFO_cHRM = 0x0004U;
enum PNG_INFO_PLTE = 0x0008U;
enum PNG_INFO_tRNS = 0x0010U;
enum PNG_INFO_bKGD = 0x0020U;
enum PNG_INFO_hIST = 0x0040U;
enum PNG_INFO_pHYs = 0x0080U;
enum PNG_INFO_oFFs = 0x0100U;
enum PNG_INFO_tIME = 0x0200U;
enum PNG_INFO_pCAL = 0x0400U;
enum PNG_INFO_sRGB = 0x0800U;
enum PNG_INFO_iCCP = 0x1000U;
enum PNG_INFO_sPLT = 0x2000U;
enum PNG_INFO_sCAL = 0x4000U;
enum PNG_INFO_IDAT = 0x8000U;
enum PNG_INFO_eXIf = 0x10000U;

struct png_row_info
{
   png_uint_32 width;    /* width of row */
   size_t rowbytes;      /* number of bytes in row */
   png_byte color_type;  /* color type of row */
   png_byte bit_depth;   /* bit depth of row */
   png_byte channels;    /* number of channels (1, 2, 3, or 4) */
   png_byte pixel_depth; /* bits per pixel (depth * channels) */
}
alias png_row_infop = png_row_info*;
alias png_row_infopp = png_row_info**;

alias png_error_ptr = void function (png_structp, png_const_charp);
alias png_rw_ptr = void function (png_structp, png_bytep, size_t);
alias png_flush_ptr = void function (png_structp);
alias png_read_status_ptr = void function (png_structp, png_uint_32, int);
alias png_write_status_ptr = void function (png_structp, png_uint_32, int);

static if (PNG_PROGRESSIVE_READ_SUPPORTED) {
    alias png_progressive_info_ptr = void function (png_structp, png_infop);
    alias png_progressive_end_ptr = void function (png_structp, png_infop);
    alias png_progressive_row_ptr = void function (png_structp, png_bytep, png_uint_32, int);
}

static if (PNG_READ_USER_TRANSFORM_SUPPORTED || PNG_WRITE_USER_TRANSFORM_SUPPORTED) {
    alias png_user_transform_ptr = void function (png_structp, png_row_infop, png_bytep);
}

static if (PNG_USER_CHUNKS_SUPPORTED) {
    alias png_user_chunk_ptr = int function (png_structp, png_unknown_chunkp);
}

static if (PNG_SETJMP_SUPPORTED) {
    // note, following is signature of longjmp
    alias png_longjmp_ptr = void function(ref jmp_buf, int);
    // PNG_FUNCTION(void, (PNGCAPI *png_longjmp_ptr), PNGARG((jmp_buf, int)), typedef);
}

enum PNG_TRANSFORM_IDENTITY = 0x0000;
enum PNG_TRANSFORM_STRIP_16 = 0x0001;
enum PNG_TRANSFORM_STRIP_ALPHA = 0x0002;
enum PNG_TRANSFORM_PACKING = 0x0004;
enum PNG_TRANSFORM_PACKSWAP = 0x0008;
enum PNG_TRANSFORM_EXPAND = 0x0010;
enum PNG_TRANSFORM_INVERT_MONO = 0x0020;
enum PNG_TRANSFORM_SHIFT = 0x0040;
enum PNG_TRANSFORM_BGR = 0x0080;
enum PNG_TRANSFORM_SWAP_ALPHA = 0x0100;
enum PNG_TRANSFORM_SWAP_ENDIAN = 0x0200;
enum PNG_TRANSFORM_INVERT_ALPHA = 0x0400;
enum PNG_TRANSFORM_STRIP_FILLER = 0x0800;
enum PNG_TRANSFORM_STRIP_FILLER_BEFORE = PNG_TRANSFORM_STRIP_FILLER;
enum PNG_TRANSFORM_STRIP_FILLER_AFTER = 0x1000;
enum PNG_TRANSFORM_GRAY_TO_RGB = 0x2000;
enum PNG_TRANSFORM_EXPAND_16 = 0x4000;
enum PNG_TRANSFORM_SCALE_16 = 0x8000;

enum PNG_FLAG_MNG_EMPTY_PLTE = 0x01;
enum PNG_FLAG_MNG_FILTER_64 = 0x04;
enum PNG_ALL_MNG_FEATURES = 0x05;

alias png_malloc_ptr = png_voidp function (png_structp, png_alloc_size_t);
alias png_free_ptr = void function (png_structp, png_voidp);

png_uint_32 png_access_version_number ();

void png_set_sig_bytes (png_structrp png_ptr, int num_bytes);

int png_sig_cmp (png_const_bytep sig, size_t start, size_t num_to_check);

extern(D)
bool png_check_sig(png_const_bytep sig, size_t n)
{
    return !png_sig_cmp(sig, 0, n);
}

png_structp png_create_read_struct (png_const_charp user_png_ver,
    png_voidp error_ptr, png_error_ptr error_fn, png_error_ptr warn_fn);

png_structp png_create_write_struct (png_const_charp user_png_ver,
    png_voidp error_ptr, png_error_ptr error_fn, png_error_ptr warn_fn);

size_t png_get_compression_buffer_size (png_const_structrp png_ptr);

void png_set_compression_buffer_size (png_structrp png_ptr, size_t size);

static if (PNG_SETJMP_SUPPORTED) {
    jmp_buf* png_set_longjmp_fn (png_structrp png_ptr,
            png_longjmp_ptr longjmp_fn, size_t jmp_buf_size);
}

extern(D)
auto png_jmpbuf(PNG)(PNG png_ptr)
{
    static assert (PNG_SETJMP_SUPPORTED, "libpng compiled without SETJMP support");
    return png_set_longjmp_fn(png_ptr, longjmp, jmp_buf.sizeof);
}

void png_longjmp (png_const_structrp png_ptr, int val);

static if (PNG_USER_MEM_SUPPORTED) {
    png_structp png_create_read_struct_2 (png_const_charp user_png_ver,
        png_voidp error_ptr, png_error_ptr error_fn, png_error_ptr warn_fn,
        png_voidp mem_ptr, png_malloc_ptr malloc_fn, png_free_ptr free_fn);

    png_structp png_create_write_struct_2 (png_const_charp user_png_ver,
        png_voidp error_ptr, png_error_ptr error_fn, png_error_ptr warn_fn,
        png_voidp mem_ptr, png_malloc_ptr malloc_fn, png_free_ptr free_fn);
}

void png_write_sig (png_structrp png_ptr);

void png_write_chunk (png_structrp png_ptr, png_const_bytep
    chunk_name, png_const_bytep data, size_t length);

void png_write_chunk_start (png_structrp png_ptr,
    png_const_bytep chunk_name, png_uint_32 length);

void png_write_chunk_data (png_structrp png_ptr,
    png_const_bytep data, size_t length);

void png_write_chunk_end (png_structrp png_ptr);

png_infop png_create_info_struct (png_const_structrp png_ptr);

void png_write_info_before_PLTE (png_structrp png_ptr, png_const_inforp info_ptr);
void png_write_info (png_structrp png_ptr, png_const_inforp info_ptr);

static if (PNG_SEQUENTIAL_READ_SUPPORTED) {
    void png_read_info (png_structrp png_ptr, png_inforp info_ptr);
}

static if (PNG_TIME_RFC1123_SUPPORTED) {
    int png_convert_to_rfc1123_buffer (ref char[29] out_, png_const_timep ptime);
}

static if (PNG_CONVERT_tIME_SUPPORTED) {
    void png_convert_from_struct_tm (png_timep ptime, const(tm)* ttime);

    void png_convert_from_time_t (png_timep ptime, time_t ttime);
}

static if (PNG_READ_EXPAND_SUPPORTED) {
    void png_set_expand (png_structrp png_ptr);
    void png_set_expand_gray_1_2_4_to_8 (png_structrp png_ptr);
    void png_set_palette_to_rgb (png_structrp png_ptr);
    void png_set_tRNS_to_alpha (png_structrp png_ptr);
}

static if (PNG_READ_EXPAND_16_SUPPORTED) {
    void png_set_expand_16 (png_structrp png_ptr);
}

static if (PNG_READ_BGR_SUPPORTED || PNG_WRITE_BGR_SUPPORTED) {
    void png_set_bgr (png_structrp png_ptr);
}

static if (PNG_READ_GRAY_TO_RGB_SUPPORTED) {
    void png_set_gray_to_rgb (png_structrp png_ptr);
}

static if (PNG_READ_RGB_TO_GRAY_SUPPORTED) {
    enum PNG_ERROR_ACTION_NONE = 1;
    enum PNG_ERROR_ACTION_WARN = 2;
    enum PNG_ERROR_ACTION_ERROR = 3;
    enum PNG_RGB_TO_GRAY_DEFAULT = -1;

    void png_set_rgb_to_gray (png_structrp png_ptr, int error_action,
        double red, double green);
    void png_set_rgb_to_gray_fixed (png_structrp png_ptr,
        int error_action, png_fixed_point red, png_fixed_point green);

    png_byte png_get_rgb_to_gray_status (png_const_structrp png_ptr);
}

static if (PNG_BUILD_GRAYSCALE_PALETTE_SUPPORTED) {
    void png_build_grayscale_palette (int bit_depth, png_colorp palette);
}

static if (PNG_READ_ALPHA_MODE_SUPPORTED) {
    enum PNG_ALPHA_PNG = 0;
    enum PNG_ALPHA_STANDARD = 1;
    enum PNG_ALPHA_ASSOCIATED = 1;
    enum PNG_ALPHA_PREMULTIPLIED = 1;
    enum PNG_ALPHA_OPTIMIZED = 2;
    enum PNG_ALPHA_BROKEN = 3;

    void png_set_alpha_mode (png_structrp png_ptr, int mode, double output_gamma);
    void png_set_alpha_mode_fixed (png_structrp png_ptr, int mode, png_fixed_point output_gamma);
}

static if (PNG_GAMMA_SUPPORTED || PNG_READ_ALPHA_MODE_SUPPORTED) {
    enum PNG_DEFAULT_sRGB = -1;
    enum PNG_GAMMA_MAC_18 = -2;
    enum PNG_GAMMA_sRGB = 220000;
    enum PNG_GAMMA_LINEAR = PNG_FP_1;
}

static if (PNG_READ_STRIP_ALPHA_SUPPORTED) {
    void png_set_strip_alpha (png_structrp png_ptr);
}

static if (PNG_READ_SWAP_ALPHA_SUPPORTED || PNG_WRITE_SWAP_ALPHA_SUPPORTED) {
    void png_set_swap_alpha (png_structrp png_ptr);
}

static if (PNG_READ_INVERT_ALPHA_SUPPORTED || PNG_WRITE_INVERT_ALPHA_SUPPORTED) {
    void png_set_invert_alpha (png_structrp png_ptr);
}

static if (PNG_READ_FILLER_SUPPORTED || PNG_WRITE_FILLER_SUPPORTED) {
    void png_set_filler (png_structrp png_ptr, png_uint_32 filler, int flags);
    enum PNG_FILLER_BEFORE = 0;
    enum PNG_FILLER_AFTER = 1;
    void png_set_add_alpha (png_structrp png_ptr, png_uint_32 filler, int flags);
}

static if (PNG_READ_SWAP_SUPPORTED || PNG_WRITE_SWAP_SUPPORTED) {
    void png_set_swap (png_structrp png_ptr);
}

static if (PNG_READ_PACK_SUPPORTED || PNG_WRITE_PACK_SUPPORTED) {
    void png_set_packing (png_structrp png_ptr);
}

static if (PNG_READ_PACKSWAP_SUPPORTED || PNG_WRITE_PACKSWAP_SUPPORTED) {
    void png_set_packswap (png_structrp png_ptr);
}

static if (PNG_READ_SHIFT_SUPPORTED || PNG_WRITE_SHIFT_SUPPORTED) {
    void png_set_shift (png_structrp png_ptr, png_const_color_8p true_bits);
}

static if (PNG_READ_INTERLACING_SUPPORTED || PNG_WRITE_INTERLACING_SUPPORTED) {
    int png_set_interlace_handling (png_structrp png_ptr);
}

static if (PNG_READ_INVERT_SUPPORTED || PNG_WRITE_INVERT_SUPPORTED) {
    void png_set_invert_mono (png_structrp png_ptr);
}

static if (PNG_READ_BACKGROUND_SUPPORTED) {
    void png_set_background (png_structrp png_ptr,
        png_const_color_16p background_color, int background_gamma_code,
        int need_expand, double background_gamma);
    void png_set_background_fixed (png_structrp png_ptr,
        png_const_color_16p background_color, int background_gamma_code,
        int need_expand, png_fixed_point background_gamma);

    enum PNG_BACKGROUND_GAMMA_UNKNOWN   = 0;
    enum PNG_BACKGROUND_GAMMA_SCREEN    = 1;
    enum PNG_BACKGROUND_GAMMA_FILE      = 2;
    enum PNG_BACKGROUND_GAMMA_UNIQUE    = 3;
}

static if (PNG_READ_SCALE_16_TO_8_SUPPORTED) {
    void png_set_scale_16 (png_structrp png_ptr);
}

static if (PNG_READ_STRIP_16_TO_8_SUPPORTED) {
    void png_set_strip_16 (png_structrp png_ptr);
}

static if (PNG_READ_QUANTIZE_SUPPORTED) {
    void png_set_quantize (png_structrp png_ptr,
        png_colorp palette, int num_palette, int maximum_colors,
        png_const_uint_16p histogram, int full_quantize);
}

static if (PNG_READ_GAMMA_SUPPORTED) {
    enum PNG_GAMMA_THRESHOLD = PNG_GAMMA_THRESHOLD_FIXED*.00001;

    void png_set_gamma (png_structrp png_ptr, double screen_gamma, double override_file_gamma);
    void png_set_gamma_fixed (png_structrp png_ptr,
        png_fixed_point screen_gamma, png_fixed_point override_file_gamma);
}

static if (PNG_WRITE_FLUSH_SUPPORTED) {
    void png_set_flush (png_structrp png_ptr, int nrows);
    void png_write_flush (png_structrp png_ptr);
}

/* Optional update palette with requested transformations */
void png_start_read_image (png_structrp png_ptr);

/* Optional call to update the users info structure */
void png_read_update_info (png_structrp png_ptr,
    png_inforp info_ptr);

static if (PNG_SEQUENTIAL_READ_SUPPORTED) {
/* Read one or more rows of image data. */
void png_read_rows (png_structrp png_ptr, png_bytepp row,
    png_bytepp display_row, png_uint_32 num_rows);
}

static if (PNG_SEQUENTIAL_READ_SUPPORTED) {
    void png_read_row (png_structrp png_ptr, png_bytep row, png_bytep display_row);
}

static if (PNG_SEQUENTIAL_READ_SUPPORTED) {
    void png_read_image (png_structrp png_ptr, png_bytepp image);
}

void png_write_row (png_structrp png_ptr, png_const_bytep row);

void png_write_rows (png_structrp png_ptr, png_bytepp row, png_uint_32 num_rows);

void png_write_image (png_structrp png_ptr, png_bytepp image);

void png_write_end (png_structrp png_ptr, png_inforp info_ptr);

static if (PNG_SEQUENTIAL_READ_SUPPORTED) {
    void png_read_end (png_structrp png_ptr, png_inforp info_ptr);
}

void png_destroy_info_struct (png_const_structrp png_ptr, png_infopp info_ptr_ptr);

void png_destroy_read_struct (png_structpp png_ptr_ptr,
    png_infopp info_ptr_ptr, png_infopp end_info_ptr_ptr);

void png_destroy_write_struct (png_structpp png_ptr_ptr, png_infopp info_ptr_ptr);

void png_set_crc_action (png_structrp png_ptr, int crit_action, int ancil_action);

enum PNG_CRC_DEFAULT = 0;
enum PNG_CRC_ERROR_QUIT = 1;
enum PNG_CRC_WARN_DISCARD = 2;
enum PNG_CRC_WARN_USE = 3;
enum PNG_CRC_QUIET_USE = 4;
enum PNG_CRC_NO_CHANGE = 5;

static if (PNG_WRITE_SUPPORTED) {
    void png_set_filter (png_structrp png_ptr, int method, int filters);
}

enum PNG_NO_FILTERS = 0x00;
enum PNG_FILTER_NONE = 0x08;
enum PNG_FILTER_SUB = 0x10;
enum PNG_FILTER_UP = 0x20;
enum PNG_FILTER_AVG = 0x40;
enum PNG_FILTER_PAETH = 0x80;
enum PNG_FAST_FILTERS = (PNG_FILTER_NONE | PNG_FILTER_SUB | PNG_FILTER_UP);
enum PNG_ALL_FILTERS = (PNG_FAST_FILTERS | PNG_FILTER_AVG | PNG_FILTER_PAETH);

enum PNG_FILTER_VALUE_NONE = 0;
enum PNG_FILTER_VALUE_SUB = 1;
enum PNG_FILTER_VALUE_UP = 2;
enum PNG_FILTER_VALUE_AVG = 3;
enum PNG_FILTER_VALUE_PAETH = 4;
enum PNG_FILTER_VALUE_LAST = 5;

static if (PNG_WRITE_SUPPORTED) {
    static if (PNG_WRITE_WEIGHTED_FILTER_SUPPORTED) {
        void png_set_filter_heuristics (png_structrp png_ptr,
            int heuristic_method, int num_weights, png_const_doublep filter_weights,
            png_const_doublep filter_costs);
        void png_set_filter_heuristics_fixed (png_structrp png_ptr,
            int heuristic_method, int num_weights,
            png_const_fixed_point_p filter_weights,
            png_const_fixed_point_p filter_costs);
    }

    enum PNG_FILTER_HEURISTIC_DEFAULT = 0;
    enum PNG_FILTER_HEURISTIC_UNWEIGHTED = 1;
    enum PNG_FILTER_HEURISTIC_WEIGHTED = 2;
    enum PNG_FILTER_HEURISTIC_LAST = 3;

    static if (PNG_WRITE_CUSTOMIZE_COMPRESSION_SUPPORTED) {
        void png_set_compression_level (png_structrp png_ptr, int level);

        void png_set_compression_mem_level (png_structrp png_ptr, int mem_level);

        void png_set_compression_strategy (png_structrp png_ptr, int strategy);

        void png_set_compression_window_bits (png_structrp png_ptr, int window_bits);

        void png_set_compression_method (png_structrp png_ptr, int method);
    }

    static if (PNG_WRITE_CUSTOMIZE_ZTXT_COMPRESSION_SUPPORTED) {
        void png_set_text_compression_level (png_structrp png_ptr, int level);

        void png_set_text_compression_mem_level (png_structrp png_ptr, int mem_level);

        void png_set_text_compression_strategy (png_structrp png_ptr, int strategy);

        void png_set_text_compression_window_bits (png_structrp png_ptr, int window_bits);

        void png_set_text_compression_method (png_structrp png_ptr, int method);
    }
}

static if (PNG_STDIO_SUPPORTED) {
    void png_init_io (png_structrp png_ptr, png_FILE_p fp);
}

void png_set_error_fn (png_structrp png_ptr, png_voidp error_ptr,
    png_error_ptr error_fn, png_error_ptr warning_fn);

png_voidp png_get_error_ptr (png_const_structrp png_ptr);

void png_set_write_fn (png_structrp png_ptr, png_voidp io_ptr,
    png_rw_ptr write_data_fn, png_flush_ptr output_flush_fn);

void png_set_read_fn (png_structrp png_ptr, png_voidp io_ptr,
    png_rw_ptr read_data_fn);

png_voidp png_get_io_ptr (png_const_structrp png_ptr);

void png_set_read_status_fn (png_structrp png_ptr, png_read_status_ptr read_row_fn);

void png_set_write_status_fn (png_structrp png_ptr, png_write_status_ptr write_row_fn);

static if (PNG_USER_MEM_SUPPORTED) {
    void png_set_mem_fn (png_structrp png_ptr, png_voidp mem_ptr,
        png_malloc_ptr malloc_fn, png_free_ptr free_fn);
    png_voidp png_get_mem_ptr (png_const_structrp png_ptr);
}

static if (PNG_READ_USER_TRANSFORM_SUPPORTED) {
    void png_set_read_user_transform_fn (png_structrp png_ptr,
        png_user_transform_ptr read_user_transform_fn);
}

static if (PNG_WRITE_USER_TRANSFORM_SUPPORTED) {
    void png_set_write_user_transform_fn (png_structrp png_ptr,
        png_user_transform_ptr write_user_transform_fn);
}

static if (PNG_USER_TRANSFORM_PTR_SUPPORTED) {
    void png_set_user_transform_info (png_structrp png_ptr,
        png_voidp user_transform_ptr, int user_transform_depth,
        int user_transform_channels);
    png_voidp png_get_user_transform_ptr (png_const_structrp png_ptr);
}

static if (PNG_USER_TRANSFORM_INFO_SUPPORTED) {
    png_uint_32 png_get_current_row_number (png_const_structrp);
    png_byte png_get_current_pass_number (png_const_structrp);
}

static if (PNG_READ_USER_CHUNKS_SUPPORTED) {
    void png_set_read_user_chunk_fn (png_structrp png_ptr,
        png_voidp user_chunk_ptr, png_user_chunk_ptr read_user_chunk_fn);
}

static if (PNG_USER_CHUNKS_SUPPORTED) {
    png_voidp png_get_user_chunk_ptr (png_const_structrp png_ptr);
}

static if (PNG_PROGRESSIVE_READ_SUPPORTED) {
    void png_set_progressive_read_fn (png_structrp png_ptr,
        png_voidp progressive_ptr, png_progressive_info_ptr info_fn,
        png_progressive_row_ptr row_fn, png_progressive_end_ptr end_fn);

    png_voidp png_get_progressive_ptr (png_const_structrp png_ptr);

    void png_process_data (png_structrp png_ptr,
        png_inforp info_ptr, png_bytep buffer, size_t buffer_size);

    size_t png_process_data_pause (png_structrp, int save);

    png_uint_32 png_process_data_skip (png_structrp);

    void png_progressive_combine_row (png_const_structrp png_ptr,
        png_bytep old_row, png_const_bytep new_row);
}

png_voidp png_malloc (png_const_structrp png_ptr, png_alloc_size_t size);

png_voidp png_calloc (png_const_structrp png_ptr, png_alloc_size_t size);

png_voidp png_malloc_warn (png_const_structrp png_ptr, png_alloc_size_t size);

void png_free (png_const_structrp png_ptr, png_voidp ptr);

void png_free_data (png_const_structrp png_ptr, png_inforp info_ptr, png_uint_32 free_me, int num);

void png_data_freer (png_const_structrp png_ptr, png_inforp info_ptr, int freer, png_uint_32 mask);

enum PNG_DESTROY_WILL_FREE_DATA = 1;
enum PNG_SET_WILL_FREE_DATA = 1;
enum PNG_USER_WILL_FREE_DATA = 2;

enum PNG_FREE_HIST = 0x0008U;
enum PNG_FREE_ICCP = 0x0010U;
enum PNG_FREE_SPLT = 0x0020U;
enum PNG_FREE_ROWS = 0x0040U;
enum PNG_FREE_PCAL = 0x0080U;
enum PNG_FREE_SCAL = 0x0100U;
static if (PNG_STORE_UNKNOWN_CHUNKS_SUPPORTED) {
    enum PNG_FREE_UNKN = 0x0200U;
}
enum PNG_FREE_PLTE = 0x1000U;
enum PNG_FREE_TRNS = 0x2000U;
enum PNG_FREE_TEXT = 0x4000U;
enum PNG_FREE_EXIF = 0x8000U;
enum PNG_FREE_ALL = 0xffffU;
enum PNG_FREE_MUL = 0x4220U;

static if (PNG_ERROR_TEXT_SUPPORTED) {
    void png_error (png_const_structrp png_ptr, png_const_charp error_message);

    void png_chunk_error (png_const_structrp png_ptr, png_const_charp error_message);
} else {
    void png_err (png_const_structrp png_ptr);
    extern(D) void png_error(S1, S2)(S1 s1, S2 s2) {
        png_err(s1);
    }
    extern(D) void png_chunk_error(S1, S2)(S1 s1, S2 s2) {
        png_err(s1);
    }
}

static if (PNG_WARNINGS_SUPPORTED) {
    void png_warning (png_const_structrp png_ptr,
        png_const_charp warning_message);

    void png_chunk_warning (png_const_structrp png_ptr,
        png_const_charp warning_message);
} else {
    extern(D) void png_warning(S1, S2)(S1 s1, S2 s2) {}
    extern(D) void png_chunk_warning(S1, S2)(S1 s1, S2 s2) {}
}

static if (PNG_BENIGN_ERRORS_SUPPORTED) {
    void png_benign_error (png_const_structrp png_ptr,
        png_const_charp warning_message);

    static if (PNG_READ_SUPPORTED) {
        void png_chunk_benign_error (png_const_structrp png_ptr,
            png_const_charp warning_message);
    }

    void png_set_benign_errors (png_structrp png_ptr, int allowed);
} else {
    static if (PNG_ALLOW_BENIGN_ERRORS) {
        alias png_benign_error = png_warning;
        alias png_chunk_benign_error = png_chunk_warning;
    } else {
        alias png_benign_error = png_error;
        alias png_chunk_benign_error = png_chunk_error;
    }
}

png_uint_32 png_get_valid (png_const_structrp png_ptr, png_const_inforp info_ptr, png_uint_32 flag);

size_t png_get_rowbytes (png_const_structrp png_ptr, png_const_inforp info_ptr);

static if (PNG_INFO_IMAGE_SUPPORTED) {
    png_bytepp png_get_rows (png_const_structrp png_ptr,
        png_const_inforp info_ptr);
    void png_set_rows (png_const_structrp png_ptr,
        png_inforp info_ptr, png_bytepp row_pointers);
}

png_byte png_get_channels (png_const_structrp png_ptr, png_const_inforp info_ptr);

static if (PNG_EASY_ACCESS_SUPPORTED) {
    png_uint_32 png_get_image_width (png_const_structrp png_ptr, png_const_inforp info_ptr);

    png_uint_32 png_get_image_height (png_const_structrp png_ptr, png_const_inforp info_ptr);

    png_byte png_get_bit_depth (png_const_structrp png_ptr, png_const_inforp info_ptr);

    png_byte png_get_color_type (png_const_structrp png_ptr, png_const_inforp info_ptr);

    png_byte png_get_filter_type (png_const_structrp png_ptr, png_const_inforp info_ptr);

    png_byte png_get_interlace_type (png_const_structrp png_ptr, png_const_inforp info_ptr);

    png_byte png_get_compression_type (png_const_structrp png_ptr, png_const_inforp info_ptr);

    png_uint_32 png_get_pixels_per_meter (png_const_structrp png_ptr, png_const_inforp info_ptr);
    png_uint_32 png_get_x_pixels_per_meter (png_const_structrp png_ptr, png_const_inforp info_ptr);
    png_uint_32 png_get_y_pixels_per_meter (png_const_structrp png_ptr, png_const_inforp info_ptr);

    float png_get_pixel_aspect_ratio (png_const_structrp png_ptr, png_const_inforp info_ptr);
    png_fixed_point png_get_pixel_aspect_ratio_fixed (png_const_structrp png_ptr,
        png_const_inforp info_ptr);

    png_int_32 png_get_x_offset_pixels (png_const_structrp png_ptr, png_const_inforp info_ptr);
    png_int_32 png_get_y_offset_pixels (png_const_structrp png_ptr, png_const_inforp info_ptr);
    png_int_32 png_get_x_offset_microns (png_const_structrp png_ptr, png_const_inforp info_ptr);
    png_int_32 png_get_y_offset_microns (png_const_structrp png_ptr, png_const_inforp info_ptr);
}

static if (PNG_READ_SUPPORTED) {
    png_const_bytep png_get_signature (png_const_structrp png_ptr,
        png_const_inforp info_ptr);
}

static if (PNG_bKGD_SUPPORTED) {
    png_uint_32 png_get_bKGD (png_const_structrp png_ptr, png_inforp info_ptr,
        png_color_16p *background);
}

static if (PNG_bKGD_SUPPORTED) {
    void png_set_bKGD (png_const_structrp png_ptr, png_inforp info_ptr,
        png_const_color_16p background);
}

static if (PNG_cHRM_SUPPORTED) {
    png_uint_32 png_get_cHRM (png_const_structrp png_ptr,
        png_const_inforp info_ptr, double *white_x, double *white_y, double *red_x,
        double *red_y, double *green_x, double *green_y, double *blue_x,
        double *blue_y);
    png_uint_32 png_get_cHRM_XYZ (png_const_structrp png_ptr,
        png_const_inforp info_ptr, double *red_X, double *red_Y, double *red_Z,
        double *green_X, double *green_Y, double *green_Z, double *blue_X,
        double *blue_Y, double *blue_Z);
    png_uint_32 png_get_cHRM_fixed (png_const_structrp png_ptr,
        png_const_inforp info_ptr,
        png_fixed_point *int_white_x, png_fixed_point *int_white_y,
        png_fixed_point *int_red_x, png_fixed_point *int_red_y,
        png_fixed_point *int_green_x, png_fixed_point *int_green_y,
        png_fixed_point *int_blue_x, png_fixed_point *int_blue_y);
    png_uint_32 png_get_cHRM_XYZ_fixed (png_const_structrp png_ptr,
        png_const_inforp info_ptr,
        png_fixed_point *int_red_X, png_fixed_point *int_red_Y,
        png_fixed_point *int_red_Z, png_fixed_point *int_green_X,
        png_fixed_point *int_green_Y, png_fixed_point *int_green_Z,
        png_fixed_point *int_blue_X, png_fixed_point *int_blue_Y,
        png_fixed_point *int_blue_Z);
}

static if (PNG_cHRM_SUPPORTED) {
    void png_set_cHRM (png_const_structrp png_ptr,
        png_inforp info_ptr,
        double white_x, double white_y, double red_x, double red_y, double green_x,
        double green_y, double blue_x, double blue_y);
    void png_set_cHRM_XYZ (png_const_structrp png_ptr,
        png_inforp info_ptr, double red_X, double red_Y, double red_Z,
        double green_X, double green_Y, double green_Z, double blue_X,
        double blue_Y, double blue_Z);
    void png_set_cHRM_fixed (png_const_structrp png_ptr,
        png_inforp info_ptr, png_fixed_point int_white_x,
        png_fixed_point int_white_y, png_fixed_point int_red_x,
        png_fixed_point int_red_y, png_fixed_point int_green_x,
        png_fixed_point int_green_y, png_fixed_point int_blue_x,
        png_fixed_point int_blue_y);
    void png_set_cHRM_XYZ_fixed (png_const_structrp png_ptr,
        png_inforp info_ptr, png_fixed_point int_red_X, png_fixed_point int_red_Y,
        png_fixed_point int_red_Z, png_fixed_point int_green_X,
        png_fixed_point int_green_Y, png_fixed_point int_green_Z,
        png_fixed_point int_blue_X, png_fixed_point int_blue_Y,
        png_fixed_point int_blue_Z);
}

static if (PNG_eXIf_SUPPORTED) {
    png_uint_32 png_get_eXIf (png_const_structrp png_ptr, png_inforp info_ptr,
        png_bytep *exif);
    void png_set_eXIf (png_const_structrp png_ptr, png_inforp info_ptr,
        const png_bytep exif);

    png_uint_32 png_get_eXIf_1 (png_const_structrp png_ptr,
        png_const_inforp info_ptr, png_uint_32 *num_exif, png_bytep *exif);
    void png_set_eXIf_1 (png_const_structrp png_ptr, png_inforp info_ptr,
        const png_uint_32 num_exif, const png_bytep exif);
}

static if (PNG_gAMA_SUPPORTED) {
    png_uint_32 png_get_gAMA (png_const_structrp png_ptr,
        png_const_inforp info_ptr, double *file_gamma);
    png_uint_32 png_get_gAMA_fixed (png_const_structrp png_ptr,
        png_const_inforp info_ptr, png_fixed_point *int_file_gamma);
}

static if (PNG_gAMA_SUPPORTED) {
    void png_set_gAMA (png_const_structrp png_ptr, png_inforp info_ptr,
        double file_gamma);
    void png_set_gAMA_fixed (png_const_structrp png_ptr, png_inforp info_ptr,
        png_fixed_point int_file_gamma);
}

static if (PNG_hIST_SUPPORTED) {
png_uint_32 png_get_hIST (png_const_structrp png_ptr,
    png_inforp info_ptr, png_uint_16p *hist);
void png_set_hIST (png_const_structrp png_ptr,
    png_inforp info_ptr, png_const_uint_16p hist);
}

png_uint_32 png_get_IHDR (png_const_structrp png_ptr,
    png_const_inforp info_ptr, png_uint_32 *width, png_uint_32 *height,
    int *bit_depth, int *color_type, int *interlace_method,
    int *compression_method, int *filter_method);

void png_set_IHDR (png_const_structrp png_ptr,
    png_inforp info_ptr, png_uint_32 width, png_uint_32 height, int bit_depth,
    int color_type, int interlace_method, int compression_method,
    int filter_method);

static if (PNG_oFFs_SUPPORTED) {
png_uint_32 png_get_oFFs (png_const_structrp png_ptr,
   png_const_inforp info_ptr, png_int_32 *offset_x, png_int_32 *offset_y,
   int *unit_type);
}

static if (PNG_oFFs_SUPPORTED) {
void png_set_oFFs (png_const_structrp png_ptr,
    png_inforp info_ptr, png_int_32 offset_x, png_int_32 offset_y,
    int unit_type);
}

static if (PNG_pCAL_SUPPORTED) {
png_uint_32 png_get_pCAL (png_const_structrp png_ptr,
    png_inforp info_ptr, png_charp *purpose, png_int_32 *X0,
    png_int_32 *X1, int *type, int *nparams, png_charp *units,
    png_charpp *params);
}

static if (PNG_pCAL_SUPPORTED) {
void png_set_pCAL (png_const_structrp png_ptr,
    png_inforp info_ptr, png_const_charp purpose, png_int_32 X0, png_int_32 X1,
    int type, int nparams, png_const_charp units, png_charpp params);
}

static if (PNG_pHYs_SUPPORTED) {
png_uint_32 png_get_pHYs (png_const_structrp png_ptr,
    png_const_inforp info_ptr, png_uint_32 *res_x, png_uint_32 *res_y,
    int *unit_type);
}

static if (PNG_pHYs_SUPPORTED) {
void png_set_pHYs (png_const_structrp png_ptr,
    png_inforp info_ptr, png_uint_32 res_x, png_uint_32 res_y, int unit_type);
}

png_uint_32 png_get_PLTE (png_const_structrp png_ptr,
   png_inforp info_ptr, png_colorp *palette, int *num_palette);

void png_set_PLTE (png_structrp png_ptr,
    png_inforp info_ptr, png_const_colorp palette, int num_palette);

static if (PNG_sBIT_SUPPORTED) {
png_uint_32 png_get_sBIT (png_const_structrp png_ptr,
    png_inforp info_ptr, png_color_8p *sig_bit);
}

static if (PNG_sBIT_SUPPORTED) {
void png_set_sBIT (png_const_structrp png_ptr,
    png_inforp info_ptr, png_const_color_8p sig_bit);
}

static if (PNG_sRGB_SUPPORTED) {
png_uint_32 png_get_sRGB (png_const_structrp png_ptr,
    png_const_inforp info_ptr, int *file_srgb_intent);
}

static if (PNG_sRGB_SUPPORTED) {
void png_set_sRGB (png_const_structrp png_ptr,
    png_inforp info_ptr, int srgb_intent);
void png_set_sRGB_gAMA_and_cHRM (png_const_structrp png_ptr,
    png_inforp info_ptr, int srgb_intent);
}

static if (PNG_iCCP_SUPPORTED) {
png_uint_32 png_get_iCCP (png_const_structrp png_ptr,
    png_inforp info_ptr, png_charpp name, int *compression_type,
    png_bytepp profile, png_uint_32 *proflen);
}

static if (PNG_iCCP_SUPPORTED) {
void png_set_iCCP (png_const_structrp png_ptr,
    png_inforp info_ptr, png_const_charp name, int compression_type,
    png_const_bytep profile, png_uint_32 proflen);
}

static if (PNG_sPLT_SUPPORTED) {
int png_get_sPLT (png_const_structrp png_ptr,
    png_inforp info_ptr, png_sPLT_tpp entries);
}

static if (PNG_sPLT_SUPPORTED) {
void png_set_sPLT (png_const_structrp png_ptr,
    png_inforp info_ptr, png_const_sPLT_tp entries, int nentries);
}

static if (PNG_TEXT_SUPPORTED) {
/* png_get_text also returns the number of text chunks in *num_text */
int png_get_text (png_const_structrp png_ptr,
    png_inforp info_ptr, png_textp *text_ptr, int *num_text);
}

/* Note while png_set_text() will accept a structure whose text,
 * language, and  translated keywords are NULL pointers, the structure
 * returned by png_get_text will always contain regular
 * zero-terminated C strings.  They might be empty strings but
 * they will never be NULL pointers.
 */

static if (PNG_TEXT_SUPPORTED) {
void png_set_text (png_const_structrp png_ptr,
    png_inforp info_ptr, png_const_textp text_ptr, int num_text);
}

static if (PNG_tIME_SUPPORTED) {
png_uint_32 png_get_tIME (png_const_structrp png_ptr,
    png_inforp info_ptr, png_timep *mod_time);
}

static if (PNG_tIME_SUPPORTED) {
void png_set_tIME (png_const_structrp png_ptr,
    png_inforp info_ptr, png_const_timep mod_time);
}

static if (PNG_tRNS_SUPPORTED) {
png_uint_32 png_get_tRNS (png_const_structrp png_ptr,
    png_inforp info_ptr, png_bytep *trans_alpha, int *num_trans,
    png_color_16p *trans_color);
}

static if (PNG_tRNS_SUPPORTED) {
void png_set_tRNS (png_structrp png_ptr,
    png_inforp info_ptr, png_const_bytep trans_alpha, int num_trans,
    png_const_color_16p trans_color);
}

static if (PNG_sCAL_SUPPORTED) {

    png_uint_32 png_get_sCAL (png_const_structrp png_ptr,
        png_const_inforp info_ptr, int *unit, double *width, double *height);

    static if (PNG_FLOATING_ARITHMETIC_SUPPORTED || PNG_FLOATING_POINT_SUPPORTED) {
        png_uint_32 png_get_sCAL_fixed (png_const_structrp png_ptr,
            png_const_inforp info_ptr, int *unit, png_fixed_point *width,
            png_fixed_point *height);
    }

    png_uint_32 png_get_sCAL_s (png_const_structrp png_ptr,
        png_const_inforp info_ptr, int *unit, png_charpp swidth, png_charpp sheight);

    void png_set_sCAL (png_const_structrp png_ptr,
        png_inforp info_ptr, int unit, double width, double height);
    void png_set_sCAL_fixed (png_const_structrp png_ptr,
        png_inforp info_ptr, int unit, png_fixed_point width,
        png_fixed_point height);
    void png_set_sCAL_s (png_const_structrp png_ptr,
        png_inforp info_ptr, int unit,
        png_const_charp swidth, png_const_charp sheight);
}

static if (PNG_SET_UNKNOWN_CHUNKS_SUPPORTED) {
    static if (PNG_HANDLE_AS_UNKNOWN_SUPPORTED) {
        void png_set_keep_unknown_chunks (png_structrp png_ptr, int keep,
            png_const_bytep chunk_list, int num_chunks);
    }

    int png_handle_as_unknown (png_const_structrp png_ptr,
        png_const_bytep chunk_name);
}

static if (PNG_STORE_UNKNOWN_CHUNKS_SUPPORTED) {
    void png_set_unknown_chunks (png_const_structrp png_ptr,
        png_inforp info_ptr, png_const_unknown_chunkp unknowns,
        int num_unknowns);

    void png_set_unknown_chunk_location (png_const_structrp png_ptr,
        png_inforp info_ptr, int chunk, int location);

    int png_get_unknown_chunks (png_const_structrp png_ptr,
        png_inforp info_ptr, png_unknown_chunkpp entries);
}

void png_set_invalid (png_const_structrp png_ptr, png_inforp info_ptr, int mask);

static if (PNG_INFO_IMAGE_SUPPORTED) {
    static if (PNG_SEQUENTIAL_READ_SUPPORTED) {
        void png_read_png (png_structrp png_ptr, png_inforp info_ptr,
            int transforms, png_voidp params);
    }
    static if (PNG_WRITE_SUPPORTED) {
        void png_write_png (png_structrp png_ptr, png_inforp info_ptr,
            int transforms, png_voidp params);
    }
}

png_const_charp png_get_copyright (png_const_structrp png_ptr);
png_const_charp png_get_header_ver (png_const_structrp png_ptr);
png_const_charp png_get_header_version (png_const_structrp png_ptr);
png_const_charp png_get_libpng_ver (png_const_structrp png_ptr);

static if (PNG_MNG_FEATURES_SUPPORTED) {
    png_uint_32 png_permit_mng_features (png_structrp png_ptr,
        png_uint_32 mng_features_permitted);
}

enum PNG_HANDLE_CHUNK_AS_DEFAULT = 0;
enum PNG_HANDLE_CHUNK_NEVER = 1;
enum PNG_HANDLE_CHUNK_IF_SAFE = 2;
enum PNG_HANDLE_CHUNK_ALWAYS = 3;
enum PNG_HANDLE_CHUNK_LAST = 4;

static if (PNG_ERROR_NUMBERS_SUPPORTED) {
    void png_set_strip_error_numbers (png_structrp png_ptr, png_uint_32 strip_mode);
}

static if (PNG_SET_USER_LIMITS_SUPPORTED) {
    void png_set_user_limits (png_structrp png_ptr, png_uint_32 user_width_max,
        png_uint_32 user_height_max);
    png_uint_32 png_get_user_width_max (png_const_structrp png_ptr);
    png_uint_32 png_get_user_height_max (png_const_structrp png_ptr);
    void png_set_chunk_cache_max (png_structrp png_ptr,
        png_uint_32 user_chunk_cache_max);
    png_uint_32 png_get_chunk_cache_max (png_const_structrp png_ptr);
    void png_set_chunk_malloc_max (png_structrp png_ptr,
        png_alloc_size_t user_chunk_cache_max);
    png_alloc_size_t png_get_chunk_malloc_max (png_const_structrp png_ptr);
}

static if (PNG_INCH_CONVERSIONS_SUPPORTED) {
    png_uint_32 png_get_pixels_per_inch (png_const_structrp png_ptr,
        png_const_inforp info_ptr);

    png_uint_32 png_get_x_pixels_per_inch (png_const_structrp png_ptr,
        png_const_inforp info_ptr);

    png_uint_32 png_get_y_pixels_per_inch (png_const_structrp png_ptr,
        png_const_inforp info_ptr);

    float png_get_x_offset_inches (png_const_structrp png_ptr,
        png_const_inforp info_ptr);

    static if (PNG_FIXED_POINT_SUPPORTED) {
        png_fixed_point png_get_x_offset_inches_fixed (png_const_structrp png_ptr,
            png_const_inforp info_ptr);
    }

    float png_get_y_offset_inches (png_const_structrp png_ptr, png_const_inforp info_ptr);

    static if (PNG_FIXED_POINT_SUPPORTED) {
        png_fixed_point png_get_y_offset_inches_fixed (png_const_structrp png_ptr,
            png_const_inforp info_ptr);
    }

    static if (PNG_pHYs_SUPPORTED) {
        png_uint_32 png_get_pHYs_dpi (png_const_structrp png_ptr,
            png_const_inforp info_ptr, png_uint_32 *res_x, png_uint_32 *res_y,
            int *unit_type);
    }
}

static if (PNG_IO_STATE_SUPPORTED) {
    png_uint_32 png_get_io_state (png_const_structrp png_ptr);

    png_uint_32 png_get_io_chunk_type (png_const_structrp png_ptr);

    enum PNG_IO_NONE       = 0x0000;   /* no I/O at this moment */
    enum PNG_IO_READING    = 0x0001;   /* currently reading */
    enum PNG_IO_WRITING    = 0x0002;   /* currently writing */
    enum PNG_IO_SIGNATURE  = 0x0010;   /* currently at the file signature */
    enum PNG_IO_CHUNK_HDR  = 0x0020;   /* currently at the chunk header */
    enum PNG_IO_CHUNK_DATA = 0x0040;   /* currently at the chunk data */
    enum PNG_IO_CHUNK_CRC  = 0x0080;   /* currently at the chunk crc */
    enum PNG_IO_MASK_OP    = 0x000f;   /* current operation: reading/writing */
    enum PNG_IO_MASK_LOC   = 0x00f0;   /* current location: sig/hdr/data/crc */
}

enum PNG_INTERLACE_ADAM7_PASSES = 7;


extern(D) {

    auto PNG_PASS_START_ROW(P)(in P pass)
    {
        return (((1&~(pass))<<(3-((pass)>>1)))&7);
    }

    auto PNG_PASS_START_COL(P)(in P pass)
    {
        return (((1& (pass))<<(3-(((pass)+1)>>1)))&7);
    }

    auto PNG_PASS_ROW_OFFSET(P)(in P pass)
    {
        return ((pass)>2?(8>>(((pass)-1)>>1)):8);
    }

    auto PNG_PASS_COL_OFFSET(P)(in P pass)
    {
        return (1<<((7-(pass))>>1));
    }

    auto PNG_PASS_ROW_SHIFT(P)(in P pass)
    {
        return ((pass)>2?(8-(pass))>>1:3);
    }

    auto PNG_PASS_COL_SHIFT(P)(in P pass)
    {
        return ((pass)>1?(7-(pass))>>1:3);
    }

    auto PNG_PASS_ROWS(H, P)(in H height, in P pass)
    {
        return (((height)+(((1<<PNG_PASS_ROW_SHIFT(pass))-1)-
            PNG_PASS_START_ROW(pass)))>>PNG_PASS_ROW_SHIFT(pass));
    }

    auto PNG_PASS_COLS(W, P)(in W width, in P pass)
    {
        return (((width)+(((1<<PNG_PASS_COL_SHIFT(pass))-1)
            -PNG_PASS_START_COL(pass)))>>PNG_PASS_COL_SHIFT(pass));
    }

    auto PNG_FROM_PASS_ROWS(Y, P)(in Y y_in, in P pass)
    {
        return (((y_in)<<PNG_PASS_ROW_SHIFT(pass))+PNG_PASS_START_ROW(pass));
    }

    auto PNG_FROM_PASS_COLS(X, P)(in X x_in, in P pass)
    {
        return (((x_in)<<PNG_PASS_COL_SHIFT(pass))+PNG_PASS_START_COL(pass));
    }

    auto PNG_PASS_MASK(P, O)(in P pass, in O off)
    {
        return ((0x110145AF>>(((7-(off))-(pass))<<2)) & 0xF) |
               ((0x01145AF0>>(((7-(off))-(pass))<<2)) & 0xF0);
    }

    auto PNG_ROW_IN_INTERLACE_PASS(Y, P)(in Y y, in P pass)
    {
        return ((PNG_PASS_MASK(pass,0) >> ((y)&7)) & 1);
    }

    auto PNG_COL_IN_INTERLACE_PASS(Y, P)(in X x, in P pass)
    {
        return ((PNG_PASS_MASK(pass,1) >> ((x)&7)) & 1);
    }

    static if (PNG_READ_COMPOSITE_NODIV_SUPPORTED) {

        png_byte png_composite(in png_uint_16 fg, in png_uint_16 alpha, in png_uint_16 bg)
        {
            const temp = fg * alpha + bg * (255 - alpha) + 128;
            return ((temp + (temp >> 8)) >> 8) & 0xff;
        }

        png_uint_16 png_composite(in png_uint_32 fg, in png_uint_32 alpha, in png_uint_32 bg)
        {
            const temp = fg * alpha + bg * (65535 - alpha) + 32768;
            return ((temp + (temp >> 16)) >> 16) & 0xffff;
        }

    } else {

        png_byte png_composite(in png_uint_16 fg, in png_uint_16 alpha, in png_uint_16 bg)
        {
            return 0xff & ((fg * alpha +  bg * (255 - alpha) + 127) / 255);
        }

        png_uint_16 png_composite_16(in png_uint_32 fg, in png_uint_32 alpha, in png_uint_32 bg)
        {
            return 0xffff & ((fg * alpha + bg * (65535 - alpha) + 32767) / 65535);
        }
    }
}

static if (PNG_READ_INT_FUNCTIONS_SUPPORTED) {
    png_uint_32 png_get_uint_32 (png_const_bytep buf);
    png_uint_16 png_get_uint_16 (png_const_bytep buf);
    png_int_32 png_get_int_32 (png_const_bytep buf);
}
else {
    extern(D)
    png_uint_32 png_get_uint_32(png_const_bytep buf)
    {
        return (buf[0] << 24) + (buf[1] << 16) + (buf[2] << 8) + buf[3];
    }

    extern(D)
    png_uint_16 png_get_uint_16(png_const_bytep buf)
    {
        return (buf[0] << 8) + buf[1];
    }

    extern(D)
    png_int_32 png_get_int_32(png_const_bytep buf)
    {
        return (buf[0] & 0x80) ?
                -((( png_get_uint_32(buf) ^ 0xfffffffU) + 1) & 0x7fff_ffffU ) :
                png_get_uint_32(buf);
    }
}

png_uint_32 png_get_uint_31 (png_const_structrp png_ptr, png_const_bytep buf);

static if (PNG_WRITE_INT_FUNCTIONS_SUPPORTED) {
    void png_save_uint_32 (png_bytep buf, png_uint_32 i);
}
static if (PNG_SAVE_INT_32_SUPPORTED) {
    void png_save_int_32 (png_bytep buf, png_int_32 i);
}

static if (PNG_WRITE_INT_FUNCTIONS_SUPPORTED) {
    void png_save_uint_16 (png_bytep buf, uint i);
}


static if (PNG_CHECK_FOR_INVALID_INDEX_SUPPORTED) {

    void png_set_check_for_invalid_index (png_structrp png_ptr, int allowed);

    static if (PNG_GET_PALETTE_MAX_SUPPORTED) {
        int png_get_palette_max (png_const_structp png_ptr, png_const_infop info_ptr);
    }
}

static if (PNG_SIMPLIFIED_READ_SUPPORTED || PNG_SIMPLIFIED_WRITE_SUPPORTED) {

        enum PNG_IMAGE_VERSION = 1;

        struct png_control;
        alias png_controlp = png_control*;

    struct png_image
    {
        png_controlp opaque;    /* Initialize to NULL, free with png_image_free */
        png_uint_32  version_;   /* Set to PNG_IMAGE_VERSION */
        png_uint_32  width;     /* Image width in pixels (columns) */
        png_uint_32  height;    /* Image height in pixels (rows) */
        png_uint_32  format;    /* Image format as defined below */
        png_uint_32  flags;     /* A bit mask containing informational flags */
        png_uint_32  colormap_entries;
                                /* Number of entries in the color-map */

        png_uint_32  warning_or_error;

        char[64] message;
    }

    alias png_imagep = png_image*;

    enum PNG_IMAGE_WARNING = 1;
    enum PNG_IMAGE_ERROR = 2;


    extern(D) bool PNG_IMAGE_FAILED(const png_imagep img) {
        return (img.warning_or_error & 0x03) > 1;
    }

    enum PNG_FORMAT_FLAG_ALPHA = 0x01U;
    enum PNG_FORMAT_FLAG_COLOR = 0x02U;
    enum PNG_FORMAT_FLAG_LINEAR = 0x04U;
    enum PNG_FORMAT_FLAG_COLORMAP = 0x08U;

    static if (PNG_FORMAT_BGR_SUPPORTED) {
        enum PNG_FORMAT_FLAG_BGR = 0x10U;
    }

    static if (PNG_FORMAT_AFIRST_SUPPORTED) {
        enum PNG_FORMAT_FLAG_AFIRST = 0x20U;
    }

    enum PNG_FORMAT_FLAG_ASSOCIATED_ALPHA = 0x40U;

    enum PNG_FORMAT_GRAY = 0;
    enum PNG_FORMAT_GA = PNG_FORMAT_FLAG_ALPHA;
    enum PNG_FORMAT_AG = (PNG_FORMAT_GA|PNG_FORMAT_FLAG_AFIRST);
    enum PNG_FORMAT_RGB = PNG_FORMAT_FLAG_COLOR;
    enum PNG_FORMAT_BGR = (PNG_FORMAT_FLAG_COLOR|PNG_FORMAT_FLAG_BGR);
    enum PNG_FORMAT_RGBA = (PNG_FORMAT_RGB|PNG_FORMAT_FLAG_ALPHA);
    enum PNG_FORMAT_ARGB = (PNG_FORMAT_RGBA|PNG_FORMAT_FLAG_AFIRST);
    enum PNG_FORMAT_BGRA = (PNG_FORMAT_BGR|PNG_FORMAT_FLAG_ALPHA);
    enum PNG_FORMAT_ABGR = (PNG_FORMAT_BGRA|PNG_FORMAT_FLAG_AFIRST);

    enum PNG_FORMAT_LINEAR_Y = PNG_FORMAT_FLAG_LINEAR;
    enum PNG_FORMAT_LINEAR_Y_ALPHA = (PNG_FORMAT_FLAG_LINEAR|PNG_FORMAT_FLAG_ALPHA);
    enum PNG_FORMAT_LINEAR_RGB = PNG_FORMAT_FLAG_LINEAR|PNG_FORMAT_FLAG_COLOR;
    enum PNG_FORMAT_LINEAR_RGB_ALPHA = PNG_FORMAT_FLAG_LINEAR|PNG_FORMAT_FLAG_COLOR|PNG_FORMAT_FLAG_ALPHA;

    enum PNG_FORMAT_RGB_COLORMAP = (PNG_FORMAT_RGB|PNG_FORMAT_FLAG_COLORMAP);
    enum PNG_FORMAT_BGR_COLORMAP = (PNG_FORMAT_BGR|PNG_FORMAT_FLAG_COLORMAP);
    enum PNG_FORMAT_RGBA_COLORMAP = (PNG_FORMAT_RGBA|PNG_FORMAT_FLAG_COLORMAP);
    enum PNG_FORMAT_ARGB_COLORMAP = (PNG_FORMAT_ARGB|PNG_FORMAT_FLAG_COLORMAP);
    enum PNG_FORMAT_BGRA_COLORMAP = (PNG_FORMAT_BGRA|PNG_FORMAT_FLAG_COLORMAP);
    enum PNG_FORMAT_ABGR_COLORMAP = (PNG_FORMAT_ABGR|PNG_FORMAT_FLAG_COLORMAP);

    extern(D)
    auto PNG_IMAGE_SAMPLE_CHANNELS(in png_uint_32 fmt)
    {
        return (((fmt)&(PNG_FORMAT_FLAG_COLOR|PNG_FORMAT_FLAG_ALPHA))+1);
    }

    extern(D)
    auto PNG_IMAGE_SAMPLE_COMPONENT_SIZE(in png_uint_32 fmt)
    {
        return ((((fmt) & PNG_FORMAT_FLAG_LINEAR) >> 2)+1);
    }

    extern(D)
    auto PNG_IMAGE_SAMPLE_SIZE(in png_uint_32 fmt)
    {
        return (PNG_IMAGE_SAMPLE_CHANNELS(fmt) * PNG_IMAGE_SAMPLE_COMPONENT_SIZE(fmt));
    }

    extern(D)
    auto PNG_IMAGE_MAXIMUM_COLORMAP_COMPONENTS(in png_uint_32 fmt)
    {
        return  PNG_IMAGE_SAMPLE_CHANNELS(fmt) * 256;
    }

    extern(D) private
    auto PNG_IMAGE_PIXEL_(alias test)(in png_uint_32 fmt)
    {
        return (((fmt)&PNG_FORMAT_FLAG_COLORMAP)?1:test(fmt));
    }

    extern(D)
    auto PNG_IMAGE_PIXEL_CHANNELS(in png_uint_32 fmt)
    {
        return PNG_IMAGE_PIXEL_!(PNG_IMAGE_SAMPLE_CHANNELS)(fmt);
    }

    extern(D)
    auto PNG_IMAGE_PIXEL_COMPONENT_SIZE(in png_uint_32 fmt)
    {
        return PNG_IMAGE_PIXEL_!(PNG_IMAGE_SAMPLE_COMPONENT_SIZE)(fmt);
    }

    extern(D)
    auto PNG_IMAGE_PIXEL_SIZE(in png_uint_32 fmt)
    {
        return PNG_IMAGE_PIXEL_!(PNG_IMAGE_SAMPLE_SIZE)(fmt);
    }

    extern(D)
    auto PNG_IMAGE_ROW_STRIDE(in png_imagep image)
    {
        return PNG_IMAGE_PIXEL_CHANNELS(image.format) * image.width;
    }

    extern(D)
    auto PNG_IMAGE_BUFFER_SIZE(in png_imagep image, in png_uint_32 row_stride)
    {
        return PNG_IMAGE_PIXEL_COMPONENT_SIZE(image.format) * image.height*(row_stride);
    }

    extern(D)
    auto PNG_IMAGE_SIZE(in png_imagep image)
    {
        return PNG_IMAGE_BUFFER_SIZE(image, PNG_IMAGE_ROW_STRIDE(image));
    }

    extern(D)
    auto PNG_IMAGE_COLORMAP_SIZE(in png_imagep image)
    {
        return PNG_IMAGE_SAMPLE_SIZE(image.format) * image.colormap_entries;
    }

    enum PNG_IMAGE_FLAG_COLORSPACE_NOT_sRGB = 0x01;
    enum PNG_IMAGE_FLAG_FAST = 0x02;
    enum PNG_IMAGE_FLAG_16BIT_sRGB = 0x04;

    static if (PNG_SIMPLIFIED_READ_SUPPORTED) {

        static if (PNG_STDIO_SUPPORTED) {
            int png_image_begin_read_from_file (png_imagep image, const char *file_name);

            int png_image_begin_read_from_stdio (png_imagep image, FILE* file);
        }

        int png_image_begin_read_from_memory (png_imagep image,
            png_const_voidp memory, size_t size);

        int png_image_finish_read (png_imagep image, png_const_colorp background,
            void *buffer, png_int_32 row_stride, void *colormap);

        void png_image_free (png_imagep image);

    }

    static if (PNG_SIMPLIFIED_WRITE_SUPPORTED) {

        static if (PNG_SIMPLIFIED_WRITE_STDIO_SUPPORTED) {
            int png_image_write_to_file (png_imagep image, const char *file,
                int convert_to_8bit, const void *buffer, png_int_32 row_stride,
                const void *colormap);

            int png_image_write_to_stdio (png_imagep image, FILE *file,
                int convert_to_8_bit, const void *buffer, png_int_32 row_stride,
                const void *colormap);
        }

        int png_image_write_to_memory (png_imagep image, void *memory,
            png_alloc_size_t * memory_bytes, int convert_to_8_bit, const void *buffer,
            png_int_32 row_stride, const void *colormap);

        extern(D)
        int png_image_write_get_memory_size(png_imagep image, png_alloc_size_t size,
            int convert_to_8_bit, const void* buffer, png_int_32 row_stride,
            const void* colormap)
        {
            return png_image_write_to_memory(image, null, &size, convert_to_8_bit, buffer, row_stride, colormap);
        }

        extern(D)
        auto PNG_IMAGE_DATA_SIZE(png_imagep image)
        {
            return PNG_IMAGE_SIZE(image) + image.height;
        }

        extern(D)
        auto PNG_ZLIB_MAX_SIZE(B)(in B b)
        {
            return ((b)+(((b)+7U)>>3)+(((b)+63U)>>6)+11U);
        }

        extern(D)
        auto PNG_IMAGE_COMPRESSED_SIZE_MAX(png_imagep image)
        {
            return PNG_ZLIB_MAX_SIZE(PNG_IMAGE_DATA_SIZE(image));
        }

        extern(D)
        auto PNG_IMAGE_PNG_SIZE_MAX_(IS)(png_imagep image, IS image_size)
        {
            return ((8U/*sig*/+25U/*IHDR*/+16U/*gAMA*/+44U/*cHRM*/+12U/*IEND*/+
                ((image.format&PNG_FORMAT_FLAG_COLORMAP)?/*colormap: PLTE, tRNS*/
                12U+3U*image.colormap_entries/*PLTE data*/+
                ((image.format&PNG_FORMAT_FLAG_ALPHA)?
                12U/*tRNS*/+image.colormap_entries:0U):0U)+
                12U)+(12U*(image_size/PNG_ZBUF_SIZE))/*IDAT*/+image_size);
        }

        extern(D)
        auto PNG_IMAGE_PNG_SIZE_MAX(png_imagep image)
        {
            return PNG_IMAGE_PNG_SIZE_MAX_(image, PNG_IMAGE_COMPRESSED_SIZE_MAX(image));
        }
    }

}

static if (PNG_SET_OPTION_SUPPORTED) {
    static if (PNG_ARM_NEON_API_SUPPORTED) {
        enum PNG_ARM_NEON = 0;
    }
    enum PNG_MAXIMUM_INFLATE_WINDOW = 2;
    enum PNG_SKIP_sRGB_CHECK_PROFILE = 4;
    // static if (PNG_MIPS_MSA_API_SUPPORTED) {
    //     enum PNG_MIPS_MSA = 6;
    // }
    enum PNG_IGNORE_ADLER32 = 8;
    static if (PNG_POWERPC_VSX_API_SUPPORTED) {
        enum PNG_POWERPC_VSX = 10;
    }
    enum PNG_OPTION_NEXT = 12;

    enum PNG_OPTION_UNSET = 0;
    enum PNG_OPTION_INVALID = 1;
    enum PNG_OPTION_OFF = 2;
    enum PNG_OPTION_ON = 3;

    int png_set_option (png_structrp png_ptr, int option, int onoff);
}
