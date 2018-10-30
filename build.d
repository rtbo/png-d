/+ dub.sdl:
    dependency "dbuild" version="*"
    dependency "pkg-config" version="*"
+/

bool[string] pngOptions()
{
    return [
        "PNG_16BIT_SUPPORTED": false,
        "PNG_ALIGNED_MEMORY_SUPPORTED": false,
        "PNG_ARM_NEON_API_SUPPORTED": false,
        "PNG_ARM_NEON_CHECK_SUPPORTED": false,
        "PNG_BENIGN_ERRORS_SUPPORTED": false,
        "PNG_BENIGN_READ_ERRORS_SUPPORTED": false,
        "PNG_BENIGN_WRITE_ERRORS_SUPPORTED": false,
        "PNG_BUILD_GRAYSCALE_PALETTE_SUPPORTED": false,
        "PNG_CHECK_FOR_INVALID_INDEX_SUPPORTED": false,
        "PNG_COLORSPACE_SUPPORTED": false,
        "PNG_CONSOLE_IO_SUPPORTED": false,
        "PNG_CONVERT_tIME_SUPPORTED": false,
        "PNG_EASY_ACCESS_SUPPORTED": false,
        "PNG_ERROR_NUMBERS_SUPPORTED": false,
        "PNG_ERROR_TEXT_SUPPORTED": false,
        "PNG_FIXED_POINT_SUPPORTED": false,
        "PNG_FLOATING_ARITHMETIC_SUPPORTED": false,
        "PNG_FLOATING_POINT_SUPPORTED": false,
        "PNG_FORMAT_AFIRST_SUPPORTED": false,
        "PNG_FORMAT_BGR_SUPPORTED": false,
        "PNG_GAMMA_SUPPORTED": false,
        "PNG_GET_PALETTE_MAX_SUPPORTED": false,
        "PNG_HANDLE_AS_UNKNOWN_SUPPORTED": false,
        "PNG_INCH_CONVERSIONS_SUPPORTED": false,
        "PNG_INFO_IMAGE_SUPPORTED": false,
        "PNG_IO_STATE_SUPPORTED": false,
        "PNG_MNG_FEATURES_SUPPORTED": false,
        "PNG_POINTER_INDEXING_SUPPORTED": false,
        "PNG_POWERPC_VSX_API_SUPPORTED": false,
        "PNG_POWERPC_VSX_CHECK_SUPPORTED": false,
        "PNG_PROGRESSIVE_READ_SUPPORTED": false,
        "PNG_READ_16BIT_SUPPORTED": false,
        "PNG_READ_ALPHA_MODE_SUPPORTED": false,
        "PNG_READ_ANCILLARY_CHUNKS_SUPPORTED": false,
        "PNG_READ_BACKGROUND_SUPPORTED": false,
        "PNG_READ_BGR_SUPPORTED": false,
        "PNG_READ_CHECK_FOR_INVALID_INDEX_SUPPORTED": false,
        "PNG_READ_COMPOSITE_NODIV_SUPPORTED": false,
        "PNG_READ_COMPRESSED_TEXT_SUPPORTED": false,
        "PNG_READ_EXPAND_16_SUPPORTED": false,
        "PNG_READ_EXPAND_SUPPORTED": false,
        "PNG_READ_FILLER_SUPPORTED": false,
        "PNG_READ_GAMMA_SUPPORTED": false,
        "PNG_READ_GET_PALETTE_MAX_SUPPORTED": false,
        "PNG_READ_GRAY_TO_RGB_SUPPORTED": false,
        "PNG_READ_INTERLACING_SUPPORTED": false,
        "PNG_READ_INT_FUNCTIONS_SUPPORTED": false,
        "PNG_READ_INVERT_ALPHA_SUPPORTED": false,
        "PNG_READ_INVERT_SUPPORTED": false,
        "PNG_READ_OPT_PLTE_SUPPORTED": false,
        "PNG_READ_PACKSWAP_SUPPORTED": false,
        "PNG_READ_PACK_SUPPORTED": false,
        "PNG_READ_QUANTIZE_SUPPORTED": false,
        "PNG_READ_RGB_TO_GRAY_SUPPORTED": false,
        "PNG_READ_SCALE_16_TO_8_SUPPORTED": false,
        "PNG_READ_SHIFT_SUPPORTED": false,
        "PNG_READ_STRIP_16_TO_8_SUPPORTED": false,
        "PNG_READ_STRIP_ALPHA_SUPPORTED": false,
        "PNG_READ_SUPPORTED": false,
        "PNG_READ_SWAP_ALPHA_SUPPORTED": false,
        "PNG_READ_SWAP_SUPPORTED": false,
        "PNG_READ_TEXT_SUPPORTED": false,
        "PNG_READ_TRANSFORMS_SUPPORTED": false,
        "PNG_READ_UNKNOWN_CHUNKS_SUPPORTED": false,
        "PNG_READ_USER_CHUNKS_SUPPORTED": false,
        "PNG_READ_USER_TRANSFORM_SUPPORTED": false,
        "PNG_READ_bKGD_SUPPORTED": false,
        "PNG_READ_cHRM_SUPPORTED": false,
        "PNG_READ_eXIf_SUPPORTED": false,
        "PNG_READ_gAMA_SUPPORTED": false,
        "PNG_READ_hIST_SUPPORTED": false,
        "PNG_READ_iCCP_SUPPORTED": false,
        "PNG_READ_iTXt_SUPPORTED": false,
        "PNG_READ_oFFs_SUPPORTED": false,
        "PNG_READ_pCAL_SUPPORTED": false,
        "PNG_READ_pHYs_SUPPORTED": false,
        "PNG_READ_sBIT_SUPPORTED": false,
        "PNG_READ_sCAL_SUPPORTED": false,
        "PNG_READ_sPLT_SUPPORTED": false,
        "PNG_READ_sRGB_SUPPORTED": false,
        "PNG_READ_tEXt_SUPPORTED": false,
        "PNG_READ_tIME_SUPPORTED": false,
        "PNG_READ_tRNS_SUPPORTED": false,
        "PNG_READ_zTXt_SUPPORTED": false,
        "PNG_SAVE_INT_32_SUPPORTED": false,
        "PNG_SAVE_UNKNOWN_CHUNKS_SUPPORTED": false,
        "PNG_SEQUENTIAL_READ_SUPPORTED": false,
        "PNG_SETJMP_SUPPORTED": false,
        "PNG_SET_OPTION_SUPPORTED": false,
        "PNG_SET_UNKNOWN_CHUNKS_SUPPORTED": false,
        "PNG_SET_USER_LIMITS_SUPPORTED": false,
        "PNG_SIMPLIFIED_READ_AFIRST_SUPPORTED": false,
        "PNG_SIMPLIFIED_READ_BGR_SUPPORTED": false,
        "PNG_SIMPLIFIED_READ_SUPPORTED": false,
        "PNG_SIMPLIFIED_WRITE_AFIRST_SUPPORTED": false,
        "PNG_SIMPLIFIED_WRITE_BGR_SUPPORTED": false,
        "PNG_SIMPLIFIED_WRITE_STDIO_SUPPORTED": false,
        "PNG_SIMPLIFIED_WRITE_SUPPORTED": false,
        "PNG_STDIO_SUPPORTED": false,
        "PNG_STORE_UNKNOWN_CHUNKS_SUPPORTED": false,
        "PNG_TEXT_SUPPORTED": false,
        "PNG_TIME_RFC1123_SUPPORTED": false,
        "PNG_UNKNOWN_CHUNKS_SUPPORTED": false,
        "PNG_USER_CHUNKS_SUPPORTED": false,
        "PNG_USER_LIMITS_SUPPORTED": false,
        "PNG_USER_MEM_SUPPORTED": false,
        "PNG_USER_TRANSFORM_INFO_SUPPORTED": false,
        "PNG_USER_TRANSFORM_PTR_SUPPORTED": false,
        "PNG_WARNINGS_SUPPORTED": false,
        "PNG_WRITE_16BIT_SUPPORTED": false,
        "PNG_WRITE_ANCILLARY_CHUNKS_SUPPORTED": false,
        "PNG_WRITE_BGR_SUPPORTED": false,
        "PNG_WRITE_CHECK_FOR_INVALID_INDEX_SUPPORTED": false,
        "PNG_WRITE_COMPRESSED_TEXT_SUPPORTED": false,
        "PNG_WRITE_CUSTOMIZE_COMPRESSION_SUPPORTED": false,
        "PNG_WRITE_CUSTOMIZE_ZTXT_COMPRESSION_SUPPORTED": false,
        "PNG_WRITE_FILLER_SUPPORTED": false,
        "PNG_WRITE_FILTER_SUPPORTED": false,
        "PNG_WRITE_FLUSH_SUPPORTED": false,
        "PNG_WRITE_GET_PALETTE_MAX_SUPPORTED": false,
        "PNG_WRITE_INTERLACING_SUPPORTED": false,
        "PNG_WRITE_INT_FUNCTIONS_SUPPORTED": false,
        "PNG_WRITE_INVERT_ALPHA_SUPPORTED": false,
        "PNG_WRITE_INVERT_SUPPORTED": false,
        "PNG_WRITE_OPTIMIZE_CMF_SUPPORTED": false,
        "PNG_WRITE_PACKSWAP_SUPPORTED": false,
        "PNG_WRITE_PACK_SUPPORTED": false,
        "PNG_WRITE_SHIFT_SUPPORTED": false,
        "PNG_WRITE_SUPPORTED": false,
        "PNG_WRITE_SWAP_ALPHA_SUPPORTED": false,
        "PNG_WRITE_SWAP_SUPPORTED": false,
        "PNG_WRITE_TEXT_SUPPORTED": false,
        "PNG_WRITE_TRANSFORMS_SUPPORTED": false,
        "PNG_WRITE_UNKNOWN_CHUNKS_SUPPORTED": false,
        "PNG_WRITE_USER_TRANSFORM_SUPPORTED": false,
        "PNG_WRITE_WEIGHTED_FILTER_SUPPORTED": false,
        "PNG_WRITE_bKGD_SUPPORTED": false,
        "PNG_WRITE_cHRM_SUPPORTED": false,
        "PNG_WRITE_eXIf_SUPPORTED": false,
        "PNG_WRITE_gAMA_SUPPORTED": false,
        "PNG_WRITE_hIST_SUPPORTED": false,
        "PNG_WRITE_iCCP_SUPPORTED": false,
        "PNG_WRITE_iTXt_SUPPORTED": false,
        "PNG_WRITE_oFFs_SUPPORTED": false,
        "PNG_WRITE_pCAL_SUPPORTED": false,
        "PNG_WRITE_pHYs_SUPPORTED": false,
        "PNG_WRITE_sBIT_SUPPORTED": false,
        "PNG_WRITE_sCAL_SUPPORTED": false,
        "PNG_WRITE_sPLT_SUPPORTED": false,
        "PNG_WRITE_sRGB_SUPPORTED": false,
        "PNG_WRITE_tEXt_SUPPORTED": false,
        "PNG_WRITE_tIME_SUPPORTED": false,
        "PNG_WRITE_tRNS_SUPPORTED": false,
        "PNG_WRITE_zTXt_SUPPORTED": false,
        "PNG_bKGD_SUPPORTED": false,
        "PNG_cHRM_SUPPORTED": false,
        "PNG_eXIf_SUPPORTED": false,
        "PNG_gAMA_SUPPORTED": false,
        "PNG_hIST_SUPPORTED": false,
        "PNG_iCCP_SUPPORTED": false,
        "PNG_iTXt_SUPPORTED": false,
        "PNG_oFFs_SUPPORTED": false,
        "PNG_pCAL_SUPPORTED": false,
        "PNG_pHYs_SUPPORTED": false,
        "PNG_sBIT_SUPPORTED": false,
        "PNG_sCAL_SUPPORTED": false,
        "PNG_sPLT_SUPPORTED": false,
        "PNG_sRGB_SUPPORTED": false,
        "PNG_tEXt_SUPPORTED": false,
        "PNG_tIME_SUPPORTED": false,
        "PNG_tRNS_SUPPORTED": false,
        "PNG_zTXt_SUPPORTED": false,
    ];
}

string[string] pngSettings()
{
    return [
        "PNG_API_RULE":                     "0",
        "PNG_DEFAULT_READ_MACROS":          "1",
        "PNG_GAMMA_THRESHOLD_FIXED":        "5000",
        "PNG_IDAT_READ_SIZE":               "PNG_ZBUF_SIZE",
        "PNG_INFLATE_BUF_SIZE":             "1024",
        "PNG_MAX_GAMMA_8":                  "11",
        "PNG_QUANTIZE_BLUE_BITS":           "5",
        "PNG_QUANTIZE_GREEN_BITS":          "5",
        "PNG_QUANTIZE_RED_BITS":            "5",
        "PNG_TEXT_Z_DEFAULT_COMPRESSION":   "-1",
        "PNG_TEXT_Z_DEFAULT_STRATEGY":      "0",
        "PNG_USER_CHUNK_CACHE_MAX":         "1000",
        "PNG_USER_CHUNK_MALLOC_MAX":        "8000000",
        "PNG_USER_HEIGHT_MAX":              "1000000",
        "PNG_USER_WIDTH_MAX":               "1000000",
        "PNG_ZBUF_SIZE":                    "8192",
        "PNG_ZLIB_VERNUM":                  "0x12b0",
        "PNG_Z_DEFAULT_COMPRESSION":        "-1",
        "PNG_Z_DEFAULT_NOFILTER_STRATEGY":  "0",
        "PNG_Z_DEFAULT_STRATEGY":           "1",
        "PNG_sCAL_PRECISION":               "5",
        "PNG_sRGB_PROFILE_CHECKS":          "2",
    ];
}

void pngLibConf(in string pnglibconf, ref bool[string] options, ref string[string] settings)
{
    import std.file : readText;
    import std.regex : matchAll, regex;
    import std.string : splitLines;

    auto optionReg = regex(`^\s*#define\s+(PNG_\w+_SUPPORTED)\s*$`);
    auto settingReg = regex(`^\s*#define\s+(PNG_\w+)\s+(.+)\s*$`);

    const conf = readText(pnglibconf).splitLines();

    foreach (l; conf) {
        auto optM = matchAll(l, optionReg);
        if (optM) {
            auto option = optM.front[1] in options;
            if (option) *option = true;
            continue;
        }
        auto setM = matchAll(l, settingReg);
        if (setM) {
            auto setting = setM.front[1] in settings;
            if (setting) *setting = setM.front[2];
        }
    }
}

void genConfD(in bool[string] options, in string[string] settings)
{
    import std.path : buildPath;
    import std.process : environment;
    import std.stdio : File, stdout;

    const path = buildPath(
        environment.get("DUB_PACKAGE_DIR", "."), "source", "libpng", "libconf.d"
    );
    stdout.writeln("Editing ", path);

    auto dconf = File(path, "w");
    dconf.writeln("module libpng.libconf;");
    dconf.writeln();
    dconf.writeln("// options");
    foreach (opt, val; options) {
        dconf.writefln("enum %s = %s;", opt, val);
    }
    dconf.writeln();
    dconf.writeln("// settings");
    foreach (set, val; settings) {
        dconf.writefln("enum %s = %s;", set, val);
    }
}

void main()
{
    import dbuild;
    import pkg_config;
    import std.file : exists;
    import std.path : buildPath;
    import std.process : environment;
    import std.stdio : File, stderr, stdout;

    auto options = pngOptions();
    auto settings = pngSettings();
    bool foundLibconf;

    string[] lflags;

    try {
        auto lib = pkgConfig("libpng", "1.8")
            .cflags()
            .libs()
            .msvc()
            .invoke();
        // dub#1453 not merged
        // lib.echoDubLines();
        lflags ~= lib.lflags;
        foreach (ip; lib.includePaths) {
            const libconf = buildPath(ip, "pnglibconf.h");
            if (exists(libconf)) {
                stdout.writefln("found %s", libconf);
                pngLibConf(libconf, options, settings);
                foundLibconf = true;
                break;
            }
        }
    }
    catch (Exception ex) {

        auto cmakeOptions = [
            "-DPNG_SHARED=OFF", "-DPNG_STATIC=ON", "-DPNG_TESTS=OFF"
        ];

        try {
            pkgConfig("zlib").invoke();
        }
        catch(Exception ex) {
            // either pkg-config not installed, or zlib not found by pkg-config

            stdout.writeln("Could not find zlib. Building from source...");

            auto zlibSrc = archiveFetchSource(
                "https://zlib.net/zlib-1.2.11.tar.gz",
                "1c9f62f0778697a09d36121ead88e08e"
            );
            auto zlibCMake = CMake.create().buildSystem();
            version(Windows) {
                const zlibTargetName = "zlibstatic";
            }
            else {
                const zlibTargetName = "libz.a";
            }
            auto zlibRes = Build
                .dubWorkDir("zlib")
                .src(zlibSrc)
                .release()
                .target(libTarget(zlibTargetName))
                .build(zlibCMake);

            cmakeOptions ~= [ "-DPNG_BUILD_ZLIB="~zlibRes.dirs.installDir, 
                "-DZLIB_INCLUDE_DIR="~zlibRes.dirs.installDir.buildPath("include") ];
        }

        auto src = archiveFetchSource(
            "https://prdownloads.sourceforge.net/libpng/libpng-1.6.35.tar.gz",
            "d94d9587c421ac42316b6ab8f64f1b85"
        );
        auto cmake = CMake.create(null, cmakeOptions).buildSystem();
        version (Windows) {
            enum pngTarget = "libpng16_static";
        }
        else {
            enum pngTarget = "png16";
        }
        auto res = Build
            .dubWorkDir("png")
            .src(src)
            .release()
            .target(libTarget(pngTarget))
            .build(cmake);

        // dub#1453 not merged
        // stdout.writefln(`dub:sdl:sourceFiles "%s"`, res.artifact("png16"));
        lflags ~= res.artifact(pngTarget);

        const possibleLibConfs = [
            res.dirs.install("include", "pnglibconf.h"),
            res.dirs.install("include", "libpng16", "pnglibconf.h"),
        ];
        foreach (plc; possibleLibConfs) {
            stdout.writefln("found %s", plc);
            pngLibConf(plc, options, settings);
            foundLibconf = true;
            break;
        }
    }
    if (!foundLibconf) {
        stderr.writeln("Warning: Could not find pnglibconf.h. " ~
            "Using conservative configuration in libpng.libconf.");
    }
    genConfD(options, settings);

    version(Windows) {
        lflags ~= "/NODEFAULTLIB:libcmt";
        lflags ~= "msvcrt.lib";
    }

    // following will be replaced by dub#1453

    const flagFilename = buildPath(environment.get("DUB_PACKAGE_DIR", "."), "linker_flags.txt");
    stdout.writeln("generating ", flagFilename);

    auto flagF = File(flagFilename, "w");
    foreach (lf; lflags) {
        flagF.writeln(lf);
    }
}
