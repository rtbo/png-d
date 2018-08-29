
import libpng.png;
import std.exception;
import std.stdio;
import std.string;

struct Img
{
    uint[] data;
    uint[2] size;

    this(in uint width, in uint height)
    {
        data = new uint[width * height];
        size = [ width, height ];
    }
}

Img decode (const(ubyte)[] pngData)
{
    png_image pimg;
    pimg.version_ = PNG_IMAGE_VERSION;
    enforce(png_image_begin_read_from_memory(&pimg, &pngData[0], pngData.length));
    scope(exit) png_image_free(&pimg);
    pimg.format = PNG_FORMAT_BGRA; // little endian ARGB

    auto img = Img(pimg.width, pimg.height);
    enforce(png_image_finish_read(&pimg, null, &img.data[0], pimg.width*4, null));

    return img;
}

void encode_to_file(in Img img, in string filename)
{
    png_image pimg;
    pimg.format = PNG_FORMAT_BGRA;
    pimg.version_ = PNG_IMAGE_VERSION;
    pimg.width = img.size[0];
    pimg.height = img.size[1];

    png_image_write_to_file(&pimg, filename.toStringz, 0, &img.data[0], 0, null);
}

void main()
{
    const pngData = cast(immutable(ubyte)[])import("dlang_logo.png");
    auto img = decode(pngData);

    // inverting red and blue channels
    foreach(r; 0 .. img.size[1]) {
        foreach (c; 0 .. img.size[0]) {
            const ind = r * img.size[0] + c;
            const uint px = img.data[ind];
            img.data[ind] =
                ( px & 0xff000000)          |   // A
                ((px & 0x000000ff) << 16)   |   // R
                ( px & 0x0000ff00)          |   // G
                ((px & 0x00ff0000) >> 16);      // B
        }
    }

    encode_to_file(img, "dlang_logo_blue.png");
}
