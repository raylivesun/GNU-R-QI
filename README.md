# Lzlib Manual
<html lang="en"><head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-15">
<meta name="description" content="Lzlib Manual">
<meta name="generator" content="makeinfo 4.13+">
<link title="Top" rel="top" href="#Top">
<link href="http://www.gnu.org/software/texinfo/" rel="generator-home" title="Texinfo Homepage">
<meta http-equiv="Content-Style-Type" content="text/css">
</head>
<body>
<div class="node">
<a name="Top"></a>
<p></p><hr>
Next:&nbsp;<a rel="next" accesskey="n" href="#Introduction">Introduction</a>,
Up:&nbsp;<a rel="up" accesskey="u" href="#dir">(dir)</a>

</div>

<h2 class="unnumbered">Lzlib Manual</h2>

<p>This manual is for Lzlib (version 1.14, 20 January 2024).

</p><ul class="menu">
<li><a accesskey="1" href="#Introduction">Introduction</a>:              Purpose and features of lzlib
</li><li><a accesskey="2" href="#Library-version">Library version</a>:           Checking library version
</li><li><a accesskey="3" href="#Buffering">Buffering</a>:                 Sizes of lzlib's buffers
</li><li><a accesskey="4" href="#Parameter-limits">Parameter limits</a>:          Min / max values for some parameters
</li><li><a accesskey="5" href="#Compression-functions">Compression functions</a>:     Descriptions of the compression functions
</li><li><a accesskey="6" href="#Decompression-functions">Decompression functions</a>:   Descriptions of the decompression functions
</li><li><a accesskey="7" href="#Error-codes">Error codes</a>:               Meaning of codes returned by functions
</li><li><a accesskey="8" href="#Error-messages">Error messages</a>:            Error messages corresponding to error codes
</li><li><a accesskey="9" href="#Invoking-minilzip">Invoking minilzip</a>:         Command-line interface of the test program
</li><li><a href="#Data-format">Data format</a>:               Detailed format of the compressed data
</li><li><a href="#Examples">Examples</a>:                  A small tutorial with examples
</li><li><a href="#Problems">Problems</a>:                  Reporting bugs
</li><li><a href="#Concept-index">Concept index</a>:             Index of concepts
</li></ul>

   <pre class="sp">
</pre>
Copyright ? 2009-2024 Antonio Diaz Diaz.

   <p>This manual is free documentation: you have unlimited permission to copy,
distribute, and modify it.

</p><div class="node">
<a name="Introduction"></a>
<p></p><hr>
Next:&nbsp;<a rel="next" accesskey="n" href="#Library-version">Library version</a>,
Previous:&nbsp;<a rel="previous" accesskey="p" href="#Top">Top</a>,
Up:&nbsp;<a rel="up" accesskey="u" href="#Top">Top</a>

</div>

<h2 class="chapter">1 Introduction</h2>

<p><a name="index-introduction-1"></a>
<a href="http://www.nongnu.org/lzip/lzlib.html">Lzlib</a>
is a data compression library providing in-memory LZMA compression and
decompression functions, including integrity checking of the decompressed
data. The compressed data format used by the library is the lzip format. 
Lzlib is written in C.

   </p><p>The lzip file format is designed for data sharing and long-term archiving,
taking into account both data integrity and decoder availability:

     </p><ul>
<li>The lzip format provides very safe integrity checking and some data
recovery means. The program
<a href="http://www.nongnu.org/lzip/manual/lziprecover_manual.html#Data-safety">lziprecover</a>
can repair bit flip errors (one of the most common forms of data corruption)
in lzip files, and provides data recovery capabilities, including
error-checked merging of damaged copies of a file.

     </li><li>The lzip format is as simple as possible (but not simpler). The lzip
manual provides the source code of a simple decompressor along with a
detailed explanation of how it works, so that with the only help of the
lzip manual it would be possible for a digital archaeologist to extract
the data from a lzip file long after quantum computers eventually
render LZMA obsolete.

     </li><li>Additionally the lzip reference implementation is copylefted, which
guarantees that it will remain free forever. 
</li></ul>

   <p>A nice feature of the lzip format is that a corrupt byte is easier to repair
the nearer it is from the beginning of the file. Therefore, with the help of
lziprecover, losing an entire archive just because of a corrupt byte near
the beginning is a thing of the past.

   </p><p>The functions and variables forming the interface of the compression library
are declared in the file '<samp><span class="samp">lzlib.h</span></samp>'. Usage examples of the library are
given in the files '<samp><span class="samp">bbexample.c</span></samp>', '<samp><span class="samp">ffexample.c</span></samp>', and
'<samp><span class="samp">minilzip.c</span></samp>' from the source distribution.

   </p><p>As '<samp><span class="samp">lzlib.h</span></samp>' can be used by C and C++ programs, it must not impose a
choice of system headers on the program by including one of them. Therefore
it is the responsibility of the program using lzlib to include before
'<samp><span class="samp">lzlib.h</span></samp>' some header that declares the type '<samp><span class="samp">uint8_t</span></samp>'. There are
at least four such headers in C and C++: '<samp><span class="samp">stdint.h</span></samp>', '<samp><span class="samp">cstdint</span></samp>',
'<samp><span class="samp">inttypes.h</span></samp>', and '<samp><span class="samp">cinttypes</span></samp>'.

   </p><p>All the library functions are thread safe. The library does not install any
signal handler. The decoder checks the consistency of the compressed data,
so the library should never crash even in case of corrupted input.

   </p><p>Compression/decompression is done by repeatedly calling a couple of
read/write functions until all the data have been processed by the library. 
This interface is safer and less error prone than the traditional zlib
interface.

   </p><p>Compression/decompression is done when the read function is called. This
means the value returned by the position functions is not updated until a
read call, even if a lot of data are written. If you want the data to be
compressed in advance, just call the read function with a <var>size</var> equal
to 0.

   </p><p>If all the data to be compressed are written in advance, lzlib automatically
adjusts the header of the compressed data to use the largest dictionary size
that does not exceed neither the data size nor the limit given to
'<samp><span class="samp">LZ_compress_open</span></samp>'. This feature reduces the amount of memory needed for
decompression and allows minilzip to produce identical compressed output as
lzip.

   </p><p>Lzlib correctly decompresses a data stream which is the concatenation of
two or more compressed data streams. The result is the concatenation of the
corresponding decompressed data streams. Integrity testing of concatenated
compressed data streams is also supported.

   </p><p>Lzlib is able to compress and decompress streams of unlimited size by
automatically creating multimember output. The members so created are large,
about 2&nbsp;PiB<!-- /@w --> each.

   </p><p>In spite of its name (Lempel-Ziv-Markov chain-Algorithm), LZMA is not a
concrete algorithm; it is more like "any algorithm using the LZMA coding
scheme". For example, the option <samp><span class="option">-0</span></samp> of lzip uses the scheme in
almost the simplest way possible; issuing the longest match it can find, or
a literal byte if it can't find a match. Inversely, a much more elaborated
way of finding coding sequences of minimum size than the one currently used
by lzip could be developed, and the resulting sequence could also be coded
using the LZMA coding scheme.

   </p><p>Lzlib currently implements two variants of the LZMA algorithm: fast (used by
option <samp><span class="option">-0</span></samp> of minilzip) and normal (used by all other compression levels).

   </p><p>The high compression of LZMA comes from combining two basic, well-proven
compression ideas: sliding dictionaries (LZ77) and markov models (the thing
used by every compression algorithm that uses a range encoder or similar
order-0 entropy coder as its last stage) with segregation of contexts
according to what the bits are used for.

   </p><p>The ideas embodied in lzlib are due to (at least) the following people:
Abraham Lempel and Jacob Ziv (for the LZ algorithm), Andrei Markov (for the
definition of Markov chains), G.N.N. Martin (for the definition of range
encoding), Igor Pavlov (for putting all the above together in LZMA), and
Julian Seward (for bzip2's CLI).

   </p><p>LANGUAGE NOTE: Uncompressed = not compressed = plain data; it may never have
been compressed. Decompressed is used to refer to data which have undergone
the process of decompression.

</p><div class="node">
<a name="Library-version"></a>
<p></p><hr>
Next:&nbsp;<a rel="next" accesskey="n" href="#Buffering">Buffering</a>,
Previous:&nbsp;<a rel="previous" accesskey="p" href="#Introduction">Introduction</a>,
Up:&nbsp;<a rel="up" accesskey="u" href="#Top">Top</a>

</div>

<h2 class="chapter">2 Library version</h2>

<p><a name="index-library-version-2"></a>
One goal of lzlib is to keep perfect backward compatibility with older
versions of itself down to 1.0. Any application working with an older lzlib
should work with a newer lzlib. Installing a newer lzlib should not break
anything. This chapter describes the constants and functions that the
application can use to discover the version of the library being used. All
of them are declared in '<samp><span class="samp">lzlib.h</span></samp>'.

</p><div class="defun">
-- Constant: <b>LZ_API_VERSION</b><var><a name="index-LZ_005fAPI_005fVERSION-3"></a></var><br>
<blockquote><p>This constant is defined in '<samp><span class="samp">lzlib.h</span></samp>' and works as a version test
macro. The application should check at compile time that LZ_API_VERSION is
greater than or equal to the version required by the application:

     </p><pre class="example">          #if !defined LZ_API_VERSION || LZ_API_VERSION &lt; 1012
          #error "lzlib 1.12 or newer needed."
          #endif
</pre>
        <p>Before version 1.8, lzlib didn't define LZ_API_VERSION.<br>
LZ_API_VERSION was first defined in lzlib 1.8 to 1.<br>
Since lzlib 1.12, LZ_API_VERSION is defined as (major * 1000 + minor). 
</p></blockquote></div>

   <p>NOTE: Version test macros are the library's way of announcing functionality
to the application. They should not be confused with feature test macros,
which allow the application to announce to the library its desire to have
certain symbols and prototypes exposed.

</p><div class="defun">
-- Function: int <b>LZ_api_version</b> (<var> void </var>)<var><a name="index-LZ_005fapi_005fversion-4"></a></var><br>
<blockquote><p>If LZ_API_VERSION &gt;= 1012, this function is declared in '<samp><span class="samp">lzlib.h</span></samp>' (else
it doesn't exist). It returns the LZ_API_VERSION of the library object code
being used. The application should check at run time that the value
returned by <code>LZ_api_version</code> is greater than or equal to the version
required by the application. An application may be dynamically linked at run
time with a different version of lzlib than the one it was compiled for, and
this should not break the application as long as the library used provides
the functionality required by the application.

     </p><pre class="example">          #if defined LZ_API_VERSION &amp;&amp; LZ_API_VERSION &gt;= 1012
            if( LZ_api_version() &lt; 1012 )
              show_error( "lzlib 1.12 or newer needed." );
          #endif
</pre>
        </blockquote></div>

<div class="defun">
-- Constant: const char * <b>LZ_version_string</b><var><a name="index-LZ_005fversion_005fstring-5"></a></var><br>
<blockquote><p>This string constant is defined in the header file '<samp><span class="samp">lzlib.h</span></samp>' and
represents the version of the library being used at compile time. 
</p></blockquote></div>

<div class="defun">
-- Function: const char * <b>LZ_version</b> (<var> void </var>)<var><a name="index-LZ_005fversion-6"></a></var><br>
<blockquote><p>This function returns a string representing the version of the library being
used at run time. 
</p></blockquote></div>

<div class="node">
<a name="Buffering"></a>
<p></p><hr>
Next:&nbsp;<a rel="next" accesskey="n" href="#Parameter-limits">Parameter limits</a>,
Previous:&nbsp;<a rel="previous" accesskey="p" href="#Library-version">Library version</a>,
Up:&nbsp;<a rel="up" accesskey="u" href="#Top">Top</a>

</div>

<h2 class="chapter">3 Buffering</h2>

<p><a name="index-buffering-7"></a>
Lzlib internal functions need access to a memory chunk at least as large
as the dictionary size (sliding window). For efficiency reasons, the
input buffer for compression is twice or sixteen times as large as the
dictionary size.

   </p><p>Finally, for safety reasons, lzlib uses two more internal buffers.

   </p><p>These are the four buffers used by lzlib, and their guaranteed minimum sizes:

     </p><ul>
<li>Input compression buffer. Written to by the function
'<samp><span class="samp">LZ_compress_write</span></samp>'. For the normal variant of LZMA, its size is two
times the dictionary size set with the function '<samp><span class="samp">LZ_compress_open</span></samp>' or
64&nbsp;KiB<!-- /@w -->, whichever is larger. For the fast variant, its size is 1&nbsp;MiB<!-- /@w -->.

     </li><li>Output compression buffer. Read from by the function
'<samp><span class="samp">LZ_compress_read</span></samp>'. Its size is 64&nbsp;KiB<!-- /@w -->.

     </li><li>Input decompression buffer. Written to by the function
'<samp><span class="samp">LZ_decompress_write</span></samp>'. Its size is 64&nbsp;KiB<!-- /@w -->.

     </li><li>Output decompression buffer. Read from by the function
'<samp><span class="samp">LZ_decompress_read</span></samp>'. Its size is the dictionary size set in the header
of the member currently being decompressed or 64&nbsp;KiB<!-- /@w -->, whichever is larger. 
</li></ul>

<div class="node">
<a name="Parameter-limits"></a>
<p></p><hr>
Next:&nbsp;<a rel="next" accesskey="n" href="#Compression-functions">Compression functions</a>,
Previous:&nbsp;<a rel="previous" accesskey="p" href="#Buffering">Buffering</a>,
Up:&nbsp;<a rel="up" accesskey="u" href="#Top">Top</a>

</div>

<h2 class="chapter">4 Parameter limits</h2>

<p><a name="index-parameter-limits-8"></a>
These functions provide minimum and maximum values for some parameters. 
Current values are shown in square brackets.

</p><div class="defun">
-- Function: int <b>LZ_min_dictionary_bits</b> (<var> void </var>)<var><a name="index-LZ_005fmin_005fdictionary_005fbits-9"></a></var><br>
<blockquote><p>Returns the base 2 logarithm of the smallest valid dictionary size [12]. 
</p></blockquote></div>

<div class="defun">
-- Function: int <b>LZ_min_dictionary_size</b> (<var> void </var>)<var><a name="index-LZ_005fmin_005fdictionary_005fsize-10"></a></var><br>
<blockquote><p>Returns the smallest valid dictionary size [4 KiB]. 
</p></blockquote></div>

<div class="defun">
-- Function: int <b>LZ_max_dictionary_bits</b> (<var> void </var>)<var><a name="index-LZ_005fmax_005fdictionary_005fbits-11"></a></var><br>
<blockquote><p>Returns the base 2 logarithm of the largest valid dictionary size [29]. 
</p></blockquote></div>

<div class="defun">
-- Function: int <b>LZ_max_dictionary_size</b> (<var> void </var>)<var><a name="index-LZ_005fmax_005fdictionary_005fsize-12"></a></var><br>
<blockquote><p>Returns the largest valid dictionary size [512 MiB]. 
</p></blockquote></div>

<div class="defun">
-- Function: int <b>LZ_min_match_len_limit</b> (<var> void </var>)<var><a name="index-LZ_005fmin_005fmatch_005flen_005flimit-13"></a></var><br>
<blockquote><p>Returns the smallest valid match length limit [5]. 
</p></blockquote></div>

<div class="defun">
-- Function: int <b>LZ_max_match_len_limit</b> (<var> void </var>)<var><a name="index-LZ_005fmax_005fmatch_005flen_005flimit-14"></a></var><br>
<blockquote><p>Returns the largest valid match length limit [273]. 
</p></blockquote></div>

<div class="node">
<a name="Compression-functions"></a>
<p></p><hr>
Next:&nbsp;<a rel="next" accesskey="n" href="#Decompression-functions">Decompression functions</a>,
Previous:&nbsp;<a rel="previous" accesskey="p" href="#Parameter-limits">Parameter limits</a>,
Up:&nbsp;<a rel="up" accesskey="u" href="#Top">Top</a>

</div>

<h2 class="chapter">5 Compression functions</h2>

<p><a name="index-compression-functions-15"></a>
These are the functions used to compress data. In case of error, all of
them return -1 or 0, for signed and unsigned return values respectively,
except '<samp><span class="samp">LZ_compress_open</span></samp>' whose return value must be checked by
calling '<samp><span class="samp">LZ_compress_errno</span></samp>' before using it.

</p><div class="defun">
-- Function: struct LZ_Encoder * <b>LZ_compress_open</b> (<var> const int dictionary_size, const int match_len_limit, const unsigned long long member_size </var>)<var><a name="index-LZ_005fcompress_005fopen-16"></a></var><br>
<blockquote><p>Initializes the internal stream state for compression and returns a
pointer that can only be used as the <var>encoder</var> argument for the
other LZ_compress functions, or a null pointer if the encoder could not
be allocated.

        </p><p>The returned pointer must be checked by calling '<samp><span class="samp">LZ_compress_errno</span></samp>'
before using it. If '<samp><span class="samp">LZ_compress_errno</span></samp>' does not return '<samp><span class="samp">LZ_ok</span></samp>',
the returned pointer must not be used and should be freed with
'<samp><span class="samp">LZ_compress_close</span></samp>' to avoid memory leaks.

        </p><p><var>dictionary_size</var> sets the dictionary size to be used, in bytes. 
Valid values range from 4&nbsp;KiB<!-- /@w --> to 512&nbsp;MiB<!-- /@w -->. Note that dictionary
sizes are quantized. If the size specified does not match one of the
valid sizes, it is rounded upwards by adding up to
(<var>dictionary_size</var>&nbsp;/&nbsp;8)<!-- /@w --> to it.

        </p><p><var>match_len_limit</var> sets the match length limit in bytes. Valid values
range from 5 to 273. Larger values usually give better compression ratios
but longer compression times.

        </p><p>If <var>dictionary_size</var> is 65535 and <var>match_len_limit</var> is 16, the fast
variant of LZMA is chosen, which produces identical compressed output as
'<samp><span class="samp">lzip&nbsp;-0</span></samp>'<!-- /@w -->. (The dictionary size used is rounded upwards to
64&nbsp;KiB<!-- /@w -->).

        </p><p><a name="member_005fsize"></a><var>member_size</var> sets the member size limit in bytes. Valid values range
from 4&nbsp;KiB<!-- /@w --> to 2&nbsp;PiB<!-- /@w -->. A small member size may degrade compression
ratio, so use it only when needed. To produce a single-member data stream,
give <var>member_size</var> a value larger than the amount of data to be
produced. Values larger than 2&nbsp;PiB<!-- /@w --> are reduced to 2&nbsp;PiB<!-- /@w --> to prevent
the uncompressed size of the member from overflowing. 
</p></blockquote></div>

<div class="defun">
-- Function: int <b>LZ_compress_close</b> (<var> struct LZ_Encoder * const encoder </var>)<var><a name="index-LZ_005fcompress_005fclose-17"></a></var><br>
<blockquote><p>Frees all dynamically allocated data structures for this stream. This
function discards any unprocessed input and does not flush any pending
output. After a call to '<samp><span class="samp">LZ_compress_close</span></samp>', <var>encoder</var> can no
longer be used as an argument to any LZ_compress function. 
It is safe to call '<samp><span class="samp">LZ_compress_close</span></samp>' with a null argument. 
</p></blockquote></div>

<div class="defun">
-- Function: int <b>LZ_compress_finish</b> (<var> struct LZ_Encoder * const encoder </var>)<var><a name="index-LZ_005fcompress_005ffinish-18"></a></var><br>
<blockquote><p>Use this function to tell '<samp><span class="samp">lzlib</span></samp>' that all the data for this member
have already been written (with the function '<samp><span class="samp">LZ_compress_write</span></samp>'). 
It is safe to call '<samp><span class="samp">LZ_compress_finish</span></samp>' as many times as needed. 
After all the compressed data have been read with '<samp><span class="samp">LZ_compress_read</span></samp>'
and '<samp><span class="samp">LZ_compress_member_finished</span></samp>' returns 1, a new member can be
started with '<samp><span class="samp">LZ_compress_restart_member</span></samp>'. 
</p></blockquote></div>

<div class="defun">
-- Function: int <b>LZ_compress_restart_member</b> (<var> struct LZ_Encoder * const encoder, const unsigned long long member_size </var>)<var><a name="index-LZ_005fcompress_005frestart_005fmember-19"></a></var><br>
<blockquote><p>Use this function to start a new member in a multimember data stream. Call
this function only after '<samp><span class="samp">LZ_compress_member_finished</span></samp>' indicates that
the current member has been fully read (with the function
'<samp><span class="samp">LZ_compress_read</span></samp>'). See <a href="#member_005fsize">member_size</a>, for a description of
<var>member_size</var>. 
</p></blockquote></div>

   <p><a name="sync_005fflush"></a>

</p><div class="defun">
-- Function: int <b>LZ_compress_sync_flush</b> (<var> struct LZ_Encoder * const encoder </var>)<var><a name="index-LZ_005fcompress_005fsync_005fflush-20"></a></var><br>
<blockquote><p>Use this function to make available to '<samp><span class="samp">LZ_compress_read</span></samp>' all the data
already written with the function '<samp><span class="samp">LZ_compress_write</span></samp>'. First call
'<samp><span class="samp">LZ_compress_sync_flush</span></samp>'. Then call '<samp><span class="samp">LZ_compress_read</span></samp>' until it
returns 0.

        </p><p>This function writes at least one LZMA marker '<samp><span class="samp">3</span></samp>' ("Sync Flush" marker)
to the compressed output. Note that the sync flush marker is not allowed in
lzip files; it is a device for interactive communication between
applications using lzlib, but is useless and wasteful in a file, and is
excluded from the media type '<samp><span class="samp">application/lzip</span></samp>'. The LZMA marker
'<samp><span class="samp">2</span></samp>' ("End Of Stream" marker) is the only marker allowed in lzip files. 
See <a href="#Data-format">Data format</a>.

        </p><p>Repeated use of '<samp><span class="samp">LZ_compress_sync_flush</span></samp>' may degrade compression
ratio, so use it only when needed. If the interval between calls to
'<samp><span class="samp">LZ_compress_sync_flush</span></samp>' is large (comparable to dictionary size),
creating a multimember data stream with '<samp><span class="samp">LZ_compress_restart_member</span></samp>'
may be an alternative.

        </p><p>Combining multimember stream creation with flushing may be tricky. If there
are more bytes available than those needed to complete <var>member_size</var>,
'<samp><span class="samp">LZ_compress_restart_member</span></samp>' needs to be called when
'<samp><span class="samp">LZ_compress_member_finished</span></samp>' returns 1, followed by a new call to
'<samp><span class="samp">LZ_compress_sync_flush</span></samp>'. 
</p></blockquote></div>

<div class="defun">
-- Function: int <b>LZ_compress_read</b> (<var> struct LZ_Encoder * const encoder, uint8_t * const buffer, const int size </var>)<var><a name="index-LZ_005fcompress_005fread-21"></a></var><br>
<blockquote><p>Reads up to <var>size</var> bytes from the stream pointed to by <var>encoder</var>,
storing the results in <var>buffer</var>. If LZ_API_VERSION&nbsp;&gt;=&nbsp;1012<!-- /@w -->,
<var>buffer</var> may be a null pointer, in which case the bytes read are
discarded.

        </p><p>Returns the number of bytes actually read. This might be less than
<var>size</var>; for example, if there aren't that many bytes left in the stream
or if more bytes have to be yet written with the function
'<samp><span class="samp">LZ_compress_write</span></samp>'. Note that reading less than <var>size</var> bytes is
not an error. 
</p></blockquote></div>

<div class="defun">
-- Function: int <b>LZ_compress_write</b> (<var> struct LZ_Encoder * const encoder, uint8_t * const buffer, const int size </var>)<var><a name="index-LZ_005fcompress_005fwrite-22"></a></var><br>
<blockquote><p>Writes up to <var>size</var> bytes from <var>buffer</var> to the stream pointed to by
<var>encoder</var>. Returns the number of bytes actually written. This might be
less than <var>size</var>. Note that writing less than <var>size</var> bytes is not an
error. 
</p></blockquote></div>

<div class="defun">
-- Function: int <b>LZ_compress_write_size</b> (<var> struct LZ_Encoder * const encoder </var>)<var><a name="index-LZ_005fcompress_005fwrite_005fsize-23"></a></var><br>
<blockquote><p>Returns the maximum number of bytes that can be immediately written through
'<samp><span class="samp">LZ_compress_write</span></samp>'. For efficiency reasons, once the input buffer is
full and '<samp><span class="samp">LZ_compress_write_size</span></samp>' returns 0, almost all the buffer must
be compressed before a size greater than 0 is returned again. (This is done
to minimize the amount of data that must be copied to the beginning of the
buffer before new data can be accepted).

        </p><p>It is guaranteed that an immediate call to '<samp><span class="samp">LZ_compress_write</span></samp>' will
accept a <var>size</var> up to the returned number of bytes. 
</p></blockquote></div>

<div class="defun">
-- Function: enum LZ_Errno <b>LZ_compress_errno</b> (<var> struct LZ_Encoder * const encoder </var>)<var><a name="index-LZ_005fcompress_005ferrno-24"></a></var><br>
<blockquote><p>Returns the current error code for <var>encoder</var>. See <a href="#Error-codes">Error codes</a>. 
It is safe to call '<samp><span class="samp">LZ_compress_errno</span></samp>' with a null argument, in which
case it returns '<samp><span class="samp">LZ_bad_argument</span></samp>'. 
</p></blockquote></div>

<div class="defun">
-- Function: int <b>LZ_compress_finished</b> (<var> struct LZ_Encoder * const encoder </var>)<var><a name="index-LZ_005fcompress_005ffinished-25"></a></var><br>
<blockquote><p>Returns 1 if all the data have been read and '<samp><span class="samp">LZ_compress_close</span></samp>'
can be safely called. Otherwise it returns 0. '<samp><span class="samp">LZ_compress_finished</span></samp>'
implies '<samp><span class="samp">LZ_compress_member_finished</span></samp>'. 
</p></blockquote></div>

<div class="defun">
-- Function: int <b>LZ_compress_member_finished</b> (<var> struct LZ_Encoder * const encoder </var>)<var><a name="index-LZ_005fcompress_005fmember_005ffinished-26"></a></var><br>
<blockquote><p>Returns 1 if the current member, in a multimember data stream, has been
fully read and '<samp><span class="samp">LZ_compress_restart_member</span></samp>' can be safely called. 
Otherwise it returns 0. 
</p></blockquote></div>

<div class="defun">
-- Function: unsigned long long <b>LZ_compress_data_position</b> (<var> struct LZ_Encoder * const encoder </var>)<var><a name="index-LZ_005fcompress_005fdata_005fposition-27"></a></var><br>
<blockquote><p>Returns the number of input bytes already compressed in the current member. 
</p></blockquote></div>

<div class="defun">
-- Function: unsigned long long <b>LZ_compress_member_position</b> (<var> struct LZ_Encoder * const encoder </var>)<var><a name="index-LZ_005fcompress_005fmember_005fposition-28"></a></var><br>
<blockquote><p>Returns the number of compressed bytes already produced, but perhaps not
yet read, in the current member. 
</p></blockquote></div>

<div class="defun">
-- Function: unsigned long long <b>LZ_compress_total_in_size</b> (<var> struct LZ_Encoder * const encoder </var>)<var><a name="index-LZ_005fcompress_005ftotal_005fin_005fsize-29"></a></var><br>
<blockquote><p>Returns the total number of input bytes already compressed. 
</p></blockquote></div>

<div class="defun">
-- Function: unsigned long long <b>LZ_compress_total_out_size</b> (<var> struct LZ_Encoder * const encoder </var>)<var><a name="index-LZ_005fcompress_005ftotal_005fout_005fsize-30"></a></var><br>
<blockquote><p>Returns the total number of compressed bytes already produced, but
perhaps not yet read. 
</p></blockquote></div>

<div class="node">
<a name="Decompression-functions"></a>
<p></p><hr>
Next:&nbsp;<a rel="next" accesskey="n" href="#Error-codes">Error codes</a>,
Previous:&nbsp;<a rel="previous" accesskey="p" href="#Compression-functions">Compression functions</a>,
Up:&nbsp;<a rel="up" accesskey="u" href="#Top">Top</a>

</div>

<h2 class="chapter">6 Decompression functions</h2>

<p><a name="index-decompression-functions-31"></a>
These are the functions used to decompress data. In case of error, all of
them return -1 or 0, for signed and unsigned return values respectively,
except '<samp><span class="samp">LZ_decompress_open</span></samp>' whose return value must be checked by
calling '<samp><span class="samp">LZ_decompress_errno</span></samp>' before using it.

</p><div class="defun">
-- Function: struct LZ_Decoder * <b>LZ_decompress_open</b> (<var> void </var>)<var><a name="index-LZ_005fdecompress_005fopen-32"></a></var><br>
<blockquote><p>Initializes the internal stream state for decompression and returns a
pointer that can only be used as the <var>decoder</var> argument for the other
LZ_decompress functions, or a null pointer if the decoder could not be
allocated.

        </p><p>The returned pointer must be checked by calling '<samp><span class="samp">LZ_decompress_errno</span></samp>'
before using it. If '<samp><span class="samp">LZ_decompress_errno</span></samp>' does not return '<samp><span class="samp">LZ_ok</span></samp>',
the returned pointer must not be used and should be freed with
'<samp><span class="samp">LZ_decompress_close</span></samp>' to avoid memory leaks. 
</p></blockquote></div>

<div class="defun">
-- Function: int <b>LZ_decompress_close</b> (<var> struct LZ_Decoder * const decoder </var>)<var><a name="index-LZ_005fdecompress_005fclose-33"></a></var><br>
<blockquote><p>Frees all dynamically allocated data structures for this stream. This
function discards any unprocessed input and does not flush any pending
output. After a call to '<samp><span class="samp">LZ_decompress_close</span></samp>', <var>decoder</var> can no
longer be used as an argument to any LZ_decompress function. 
It is safe to call '<samp><span class="samp">LZ_decompress_close</span></samp>' with a null argument. 
</p></blockquote></div>

<div class="defun">
-- Function: int <b>LZ_decompress_finish</b> (<var> struct LZ_Decoder * const decoder </var>)<var><a name="index-LZ_005fdecompress_005ffinish-34"></a></var><br>
<blockquote><p>Use this function to tell '<samp><span class="samp">lzlib</span></samp>' that all the data for this stream
have already been written (with the function '<samp><span class="samp">LZ_decompress_write</span></samp>'). 
It is safe to call '<samp><span class="samp">LZ_decompress_finish</span></samp>' as many times as needed. 
It is not required to call '<samp><span class="samp">LZ_decompress_finish</span></samp>' if the input stream
only contains whole members, but not calling it prevents lzlib from
detecting a truncated member. 
</p></blockquote></div>

<div class="defun">
-- Function: int <b>LZ_decompress_reset</b> (<var> struct LZ_Decoder * const decoder </var>)<var><a name="index-LZ_005fdecompress_005freset-35"></a></var><br>
<blockquote><p>Resets the internal state of <var>decoder</var> as it was just after opening
it with the function '<samp><span class="samp">LZ_decompress_open</span></samp>'. Data stored in the
internal buffers is discarded. Position counters are set to 0. 
</p></blockquote></div>

<div class="defun">
-- Function: int <b>LZ_decompress_sync_to_member</b> (<var> struct LZ_Decoder * const decoder </var>)<var><a name="index-LZ_005fdecompress_005fsync_005fto_005fmember-36"></a></var><br>
<blockquote><p>Resets the error state of <var>decoder</var> and enters a search state that lasts
until a new member header (or the end of the stream) is found. After a
successful call to '<samp><span class="samp">LZ_decompress_sync_to_member</span></samp>', data written with
'<samp><span class="samp">LZ_decompress_write</span></samp>' is consumed and '<samp><span class="samp">LZ_decompress_read</span></samp>' returns
0 until a header is found.

        </p><p>This function is useful to discard any data preceding the first member, or
to discard the rest of the current member, for example in case of a data
error. If the decoder is already at the beginning of a member, this function
does nothing. 
</p></blockquote></div>

<div class="defun">
-- Function: int <b>LZ_decompress_read</b> (<var> struct LZ_Decoder * const decoder, uint8_t * const buffer, const int size </var>)<var><a name="index-LZ_005fdecompress_005fread-37"></a></var><br>
<blockquote><p>Reads up to <var>size</var> bytes from the stream pointed to by <var>decoder</var>,
storing the results in <var>buffer</var>. If LZ_API_VERSION&nbsp;&gt;=&nbsp;1012<!-- /@w -->,
<var>buffer</var> may be a null pointer, in which case the bytes read are
discarded.

        </p><p>Returns the number of bytes actually read. This might be less than
<var>size</var>; for example, if there aren't that many bytes left in the stream
or if more bytes have to be yet written with the function
'<samp><span class="samp">LZ_decompress_write</span></samp>'. Note that reading less than <var>size</var> bytes is
not an error.

        </p><p>'<samp><span class="samp">LZ_decompress_read</span></samp>' returns at least once per member so that
'<samp><span class="samp">LZ_decompress_member_finished</span></samp>' can be called (and trailer data
retrieved) for each member, even for empty members. Therefore,
'<samp><span class="samp">LZ_decompress_read</span></samp>' returning 0 does not mean that the end of the
stream has been reached. The increase in the value returned by
'<samp><span class="samp">LZ_decompress_total_in_size</span></samp>' can be used to tell the end of the stream
from an empty member.

        </p><p>In case of decompression error caused by corrupt or truncated data,
'<samp><span class="samp">LZ_decompress_read</span></samp>' does not signal the error immediately to the
application, but waits until all the bytes decoded have been read. This
allows tools like
<a href="http://www.nongnu.org/lzip/manual/tarlz_manual.html">tarlz</a> to
recover as much data as possible from each damaged member. 
</p></blockquote></div>

<div class="defun">
-- Function: int <b>LZ_decompress_write</b> (<var> struct LZ_Decoder * const decoder, uint8_t * const buffer, const int size </var>)<var><a name="index-LZ_005fdecompress_005fwrite-38"></a></var><br>
<blockquote><p>Writes up to <var>size</var> bytes from <var>buffer</var> to the stream pointed to by
<var>decoder</var>. Returns the number of bytes actually written. This might be
less than <var>size</var>. Note that writing less than <var>size</var> bytes is not an
error. 
</p></blockquote></div>

<div class="defun">
-- Function: int <b>LZ_decompress_write_size</b> (<var> struct LZ_Decoder * const decoder </var>)<var><a name="index-LZ_005fdecompress_005fwrite_005fsize-39"></a></var><br>
<blockquote><p>Returns the maximum number of bytes that can be immediately written through
'<samp><span class="samp">LZ_decompress_write</span></samp>'. This number varies smoothly; each compressed
byte consumed may be overwritten immediately, increasing by 1 the value
returned.

        </p><p>It is guaranteed that an immediate call to '<samp><span class="samp">LZ_decompress_write</span></samp>' will
accept a <var>size</var> up to the returned number of bytes. 
</p></blockquote></div>

<div class="defun">
-- Function: enum LZ_Errno <b>LZ_decompress_errno</b> (<var> struct LZ_Decoder * const decoder </var>)<var><a name="index-LZ_005fdecompress_005ferrno-40"></a></var><br>
<blockquote><p>Returns the current error code for <var>decoder</var>. See <a href="#Error-codes">Error codes</a>. 
It is safe to call '<samp><span class="samp">LZ_decompress_errno</span></samp>' with a null argument, in which
case it returns '<samp><span class="samp">LZ_bad_argument</span></samp>'. 
</p></blockquote></div>

<div class="defun">
-- Function: int <b>LZ_decompress_finished</b> (<var> struct LZ_Decoder * const decoder </var>)<var><a name="index-LZ_005fdecompress_005ffinished-41"></a></var><br>
<blockquote><p>Returns 1 if all the data have been read and '<samp><span class="samp">LZ_decompress_close</span></samp>'
can be safely called. Otherwise it returns 0. '<samp><span class="samp">LZ_decompress_finished</span></samp>'
does not imply '<samp><span class="samp">LZ_decompress_member_finished</span></samp>'. 
</p></blockquote></div>

<div class="defun">
-- Function: int <b>LZ_decompress_member_finished</b> (<var> struct LZ_Decoder * const decoder </var>)<var><a name="index-LZ_005fdecompress_005fmember_005ffinished-42"></a></var><br>
<blockquote><p>Returns 1 if the previous call to '<samp><span class="samp">LZ_decompress_read</span></samp>' finished reading
the current member, indicating that final values for the member are available
through '<samp><span class="samp">LZ_decompress_data_crc</span></samp>', '<samp><span class="samp">LZ_decompress_data_position</span></samp>',
and '<samp><span class="samp">LZ_decompress_member_position</span></samp>'. Otherwise it returns 0. 
</p></blockquote></div>

<div class="defun">
-- Function: int <b>LZ_decompress_member_version</b> (<var> struct LZ_Decoder * const decoder </var>)<var><a name="index-LZ_005fdecompress_005fmember_005fversion-43"></a></var><br>
<blockquote><p>Returns the version of the current member, read from the member header. 
</p></blockquote></div>

<div class="defun">
-- Function: int <b>LZ_decompress_dictionary_size</b> (<var> struct LZ_Decoder * const decoder </var>)<var><a name="index-LZ_005fdecompress_005fdictionary_005fsize-44"></a></var><br>
<blockquote><p>Returns the dictionary size of the current member, read from the member header. 
</p></blockquote></div>

<div class="defun">
-- Function: unsigned <b>LZ_decompress_data_crc</b> (<var> struct LZ_Decoder * const decoder </var>)<var><a name="index-LZ_005fdecompress_005fdata_005fcrc-45"></a></var><br>
<blockquote><p>Returns the 32 bit Cyclic Redundancy Check of the data decompressed from
the current member. The value returned is valid only when
'<samp><span class="samp">LZ_decompress_member_finished</span></samp>' returns 1. 
</p></blockquote></div>

<div class="defun">
-- Function: unsigned long long <b>LZ_decompress_data_position</b> (<var> struct LZ_Decoder * const decoder </var>)<var><a name="index-LZ_005fdecompress_005fdata_005fposition-46"></a></var><br>
<blockquote><p>Returns the number of decompressed bytes already produced, but perhaps
not yet read, in the current member. 
</p></blockquote></div>

<div class="defun">
-- Function: unsigned long long <b>LZ_decompress_member_position</b> (<var> struct LZ_Decoder * const decoder </var>)<var><a name="index-LZ_005fdecompress_005fmember_005fposition-47"></a></var><br>
<blockquote><p>Returns the number of input bytes already decompressed in the current member. 
</p></blockquote></div>

<div class="defun">
-- Function: unsigned long long <b>LZ_decompress_total_in_size</b> (<var> struct LZ_Decoder * const decoder </var>)<var><a name="index-LZ_005fdecompress_005ftotal_005fin_005fsize-48"></a></var><br>
<blockquote><p>Returns the total number of input bytes already decompressed. 
</p></blockquote></div>

<div class="defun">
-- Function: unsigned long long <b>LZ_decompress_total_out_size</b> (<var> struct LZ_Decoder * const decoder </var>)<var><a name="index-LZ_005fdecompress_005ftotal_005fout_005fsize-49"></a></var><br>
<blockquote><p>Returns the total number of decompressed bytes already produced, but
perhaps not yet read. 
</p></blockquote></div>

<div class="node">
<a name="Error-codes"></a>
<p></p><hr>
Next:&nbsp;<a rel="next" accesskey="n" href="#Error-messages">Error messages</a>,
Previous:&nbsp;<a rel="previous" accesskey="p" href="#Decompression-functions">Decompression functions</a>,
Up:&nbsp;<a rel="up" accesskey="u" href="#Top">Top</a>

</div>

<h2 class="chapter">7 Error codes</h2>

<p><a name="index-error-codes-50"></a>
Most library functions return -1 to indicate that they have failed. But
this return value only tells you that an error has occurred. To find out
what kind of error it was, you need to check the error code by calling
'<samp><span class="samp">LZ_(de)compress_errno</span></samp>'.

   </p><p>Library functions don't change the value returned by
'<samp><span class="samp">LZ_(de)compress_errno</span></samp>' when they succeed; thus, the value returned
by '<samp><span class="samp">LZ_(de)compress_errno</span></samp>' after a successful call is not
necessarily LZ_ok, and you should not use '<samp><span class="samp">LZ_(de)compress_errno</span></samp>'
to determine whether a call failed. If the call failed, then you can
examine '<samp><span class="samp">LZ_(de)compress_errno</span></samp>'.

   </p><p>The error codes are defined in the header file '<samp><span class="samp">lzlib.h</span></samp>'.

</p><div class="defun">
-- Constant: enum LZ_Errno <b>LZ_ok</b><var><a name="index-LZ_005fok-51"></a></var><br>
<blockquote><p>The value of this constant is 0 and is used to indicate that there is no error. 
</p></blockquote></div>

<div class="defun">
-- Constant: enum LZ_Errno <b>LZ_bad_argument</b><var><a name="index-LZ_005fbad_005fargument-52"></a></var><br>
<blockquote><p>At least one of the arguments passed to the library function was invalid. 
</p></blockquote></div>

<div class="defun">
-- Constant: enum LZ_Errno <b>LZ_mem_error</b><var><a name="index-LZ_005fmem_005ferror-53"></a></var><br>
<blockquote><p>No memory available. The system cannot allocate more virtual memory
because its capacity is full. 
</p></blockquote></div>

<div class="defun">
-- Constant: enum LZ_Errno <b>LZ_sequence_error</b><var><a name="index-LZ_005fsequence_005ferror-54"></a></var><br>
<blockquote><p>A library function was called in the wrong order. For example
'<samp><span class="samp">LZ_compress_restart_member</span></samp>' was called before
'<samp><span class="samp">LZ_compress_member_finished</span></samp>' indicates that the current member is
finished. 
</p></blockquote></div>

<div class="defun">
-- Constant: enum LZ_Errno <b>LZ_header_error</b><var><a name="index-LZ_005fheader_005ferror-55"></a></var><br>
<blockquote><p>An invalid member header (one with the wrong magic bytes) was read. If
this happens at the end of the data stream it may indicate trailing data. 
</p></blockquote></div>

<div class="defun">
-- Constant: enum LZ_Errno <b>LZ_unexpected_eof</b><var><a name="index-LZ_005funexpected_005feof-56"></a></var><br>
<blockquote><p>The end of the data stream was reached in the middle of a member. 
</p></blockquote></div>

<div class="defun">
-- Constant: enum LZ_Errno <b>LZ_data_error</b><var><a name="index-LZ_005fdata_005ferror-57"></a></var><br>
<blockquote><p>The data stream is corrupt. If '<samp><span class="samp">LZ_decompress_member_position</span></samp>' is 6
or less, it indicates either a format version not supported, an invalid
dictionary size, a corrupt header in a multimember data stream, or
trailing data too similar to a valid lzip header. Lziprecover can be
used to remove conflicting trailing data from a file. 
</p></blockquote></div>

<div class="defun">
-- Constant: enum LZ_Errno <b>LZ_library_error</b><var><a name="index-LZ_005flibrary_005ferror-58"></a></var><br>
<blockquote><p>A bug was detected in the library. Please, report it. See <a href="#Problems">Problems</a>. 
</p></blockquote></div>

<div class="node">
<a name="Error-messages"></a>
<p></p><hr>
Next:&nbsp;<a rel="next" accesskey="n" href="#Invoking-minilzip">Invoking minilzip</a>,
Previous:&nbsp;<a rel="previous" accesskey="p" href="#Error-codes">Error codes</a>,
Up:&nbsp;<a rel="up" accesskey="u" href="#Top">Top</a>

</div>

<h2 class="chapter">8 Error messages</h2>

<p><a name="index-error-messages-59"></a>

</p><div class="defun">
-- Function: const char * <b>LZ_strerror</b> (<var> const enum LZ_Errno lz_errno </var>)<var><a name="index-LZ_005fstrerror-60"></a></var><br>
<blockquote><p>Returns the standard error message for a given error code. The messages
are fairly short; there are no multi-line messages or embedded newlines. 
This function makes it easy for your program to report informative error
messages about the failure of a library call.

        </p><p>The value of <var>lz_errno</var> normally comes from a call to
'<samp><span class="samp">LZ_(de)compress_errno</span></samp>'. 
</p></blockquote></div>

<div class="node">
<a name="Invoking-minilzip"></a>
<p></p><hr>
Next:&nbsp;<a rel="next" accesskey="n" href="#Data-format">Data format</a>,
Previous:&nbsp;<a rel="previous" accesskey="p" href="#Error-messages">Error messages</a>,
Up:&nbsp;<a rel="up" accesskey="u" href="#Top">Top</a>

</div>

<h2 class="chapter">9 Invoking minilzip</h2>

<p><a name="index-invoking-61"></a><a name="index-options-62"></a>
Minilzip is a test program for the compression library lzlib, compatible
with lzip 1.4 or newer.

   </p><p><a href="http://www.nongnu.org/lzip/lzip.html">Lzip</a>
is a lossless data compressor with a user interface similar to the one
of gzip or bzip2. Lzip uses a simplified form of the 'Lempel-Ziv-Markov
chain-Algorithm' (LZMA) stream format to maximize interoperability. The
maximum dictionary size is 512 MiB so that any lzip file can be decompressed
on 32-bit machines. Lzip provides accurate and robust 3-factor integrity
checking. Lzip can compress about as fast as gzip (lzip&nbsp;-0)<!-- /@w --> or compress most
files more than bzip2 (lzip&nbsp;-9)<!-- /@w -->. Decompression speed is intermediate between
gzip and bzip2. Lzip is better than gzip and bzip2 from a data recovery
perspective. Lzip has been designed, written, and tested with great care to
replace gzip and bzip2 as the standard general-purpose compressed format for
Unix-like systems.

</p><p class="noindent">The format for running minilzip is:

</p><pre class="example">     minilzip [<var>options</var>] [<var>files</var>]
</pre>
   <p class="noindent">If no file names are specified, minilzip compresses (or decompresses) from
standard input to standard output. A hyphen '<samp><span class="samp">-</span></samp>' used as a <var>file</var>
argument means standard input. It can be mixed with other <var>files</var> and is
read just once, the first time it appears in the command line. Remember to
prepend <samp><span class="file">./</span></samp> to any file name beginning with a hyphen, or use '<samp><span class="samp">--</span></samp>'.

   </p><p>minilzip supports the following
<a href="http://www.nongnu.org/arg-parser/manual/arg_parser_manual.html#Argument-syntax">options</a>:

     </p><dl>
<dt><code>-h</code></dt><dt><code>--help</code></dt><dd>Print an informative help message describing the options and exit.

     <br></dd><dt><code>-V</code></dt><dt><code>--version</code></dt><dd>Print the version number of minilzip on the standard output and exit. 
This version number should be included in all bug reports.

     <br></dd><dt><code>-a</code></dt><dt><code>--trailing-error</code></dt><dd>Exit with error status 2 if any remaining input is detected after
decompressing the last member. Such remaining input is usually trailing
garbage that can be safely ignored.

     <br></dd><dt><code>-b </code><var>bytes</var></dt><dt><code>--member-size=</code><var>bytes</var></dt><dd>When compressing, set the member size limit to <var>bytes</var>. It is advisable
to keep members smaller than RAM size so that they can be repaired with
lziprecover in case of corruption. A small member size may degrade
compression ratio, so use it only when needed. Valid values range from
100&nbsp;kB<!-- /@w --> to 2&nbsp;PiB<!-- /@w -->. Defaults to 2&nbsp;PiB<!-- /@w -->.

     <br></dd><dt><code>-c</code></dt><dt><code>--stdout</code></dt><dd>Compress or decompress to standard output; keep input files unchanged. If
compressing several files, each file is compressed independently. (The
output consists of a sequence of independently compressed members). This
option (or <samp><span class="option">-o</span></samp>) is needed when reading from a named pipe (fifo) or
from a device. Use it also to recover as much of the decompressed data as
possible when decompressing a corrupt file. <samp><span class="option">-c</span></samp> overrides <samp><span class="option">-o</span></samp>
and <samp><span class="option">-S</span></samp>. <samp><span class="option">-c</span></samp> has no effect when testing.

     <br></dd><dt><code>-d</code></dt><dt><code>--decompress</code></dt><dd>Decompress the files specified. The integrity of the files specified is
checked. If a file does not exist, can't be opened, or the destination file
already exists and <samp><span class="option">--force</span></samp> has not been specified, minilzip continues
decompressing the rest of the files and exits with error status 1. If a file
fails to decompress, or is a terminal, minilzip exits immediately with error
status 2 without decompressing the rest of the files. A terminal is
considered an uncompressed file, and therefore invalid.

     <br></dd><dt><code>-f</code></dt><dt><code>--force</code></dt><dd>Force overwrite of output files.

     <br></dd><dt><code>-F</code></dt><dt><code>--recompress</code></dt><dd>When compressing, force re-compression of files whose name already has
the '<samp><span class="samp">.lz</span></samp>' or '<samp><span class="samp">.tlz</span></samp>' suffix.

     <br></dd><dt><code>-k</code></dt><dt><code>--keep</code></dt><dd>Keep (don't delete) input files during compression or decompression.

     <br></dd><dt><code>-m </code><var>bytes</var></dt><dt><code>--match-length=</code><var>bytes</var></dt><dd>When compressing, set the match length limit in bytes. After a match this
long is found, the search is finished. Valid values range from 5 to 273. 
Larger values usually give better compression ratios but longer compression
times.

     <br></dd><dt><code>-o </code><var>file</var></dt><dt><code>--output=</code><var>file</var></dt><dd>If <samp><span class="option">-c</span></samp> has not been also specified, write the (de)compressed output
to <var>file</var>; keep input files unchanged. If compressing several files,
each file is compressed independently. (The output consists of a sequence of
independently compressed members). This option (or <samp><span class="option">-c</span></samp>) is needed
when reading from a named pipe (fifo) or from a device. <samp><span class="option">-o&nbsp;-</span></samp><!-- /@w --> is
equivalent to <samp><span class="option">-c</span></samp>. <samp><span class="option">-o</span></samp> has no effect when testing.

     <p>When compressing and splitting the output in volumes, <var>file</var> is used as
a prefix, and several files named '<samp><var>file</var><span class="samp">00001.lz</span></samp>',
'<samp><var>file</var><span class="samp">00002.lz</span></samp>', etc, are created. In this case, only one input
file is allowed.

     <br></p></dd><dt><code>-q</code></dt><dt><code>--quiet</code></dt><dd>Quiet operation. Suppress all messages.

     <br></dd><dt><code>-s </code><var>bytes</var></dt><dt><code>--dictionary-size=</code><var>bytes</var></dt><dd>When compressing, set the dictionary size limit in bytes. Minilzip uses for
each file the largest dictionary size that does not exceed neither the file
size nor this limit. Valid values range from 4&nbsp;KiB<!-- /@w --> to 512&nbsp;MiB<!-- /@w -->. 
Values 12 to 29 are interpreted as powers of two, meaning 2^12 to 2^29
bytes. Dictionary sizes are quantized so that they can be coded in just one
byte (see <a href="#coded_002ddict_002dsize">coded-dict-size</a>). If the size specified does not match one of
the valid sizes, it is rounded upwards by adding up to (<var>bytes</var>&nbsp;/&nbsp;8)<!-- /@w -->
to it.

     <p>For maximum compression you should use a dictionary size limit as large
as possible, but keep in mind that the decompression memory requirement
is affected at compression time by the choice of dictionary size limit.

     <br></p></dd><dt><code>-S </code><var>bytes</var></dt><dt><code>--volume-size=</code><var>bytes</var></dt><dd>When compressing, and <samp><span class="option">-c</span></samp> has not been also specified, split the
compressed output into several volume files with names
'<samp><span class="samp">original_name00001.lz</span></samp>', '<samp><span class="samp">original_name00002.lz</span></samp>', etc, and set the
volume size limit to <var>bytes</var>. Input files are kept unchanged. Each
volume is a complete, maybe multimember, lzip file. A small volume size may
degrade compression ratio, so use it only when needed. Valid values range
from 100&nbsp;kB<!-- /@w --> to 4&nbsp;EiB<!-- /@w -->.

     <br></dd><dt><code>-t</code></dt><dt><code>--test</code></dt><dd>Check integrity of the files specified, but don't decompress them. This
really performs a trial decompression and throws away the result. Use it
together with <samp><span class="option">-v</span></samp> to see information about the files. If a file
fails the test, does not exist, can't be opened, or is a terminal, minilzip
continues testing the rest of the files. A final diagnostic is shown at
verbosity level 1 or higher if any file fails the test when testing multiple
files.

     <br></dd><dt><code>-v</code></dt><dt><code>--verbose</code></dt><dd>Verbose mode.<br>
When compressing, show the compression ratio and size for each file
processed.<br>
When decompressing or testing, further -v's (up to 4) increase the
verbosity level, showing status, compression ratio, dictionary size,
and trailer contents (CRC, data size, member size).

     <br></dd><dt><code>-0 .. -9</code></dt><dd>Compression level. Set the compression parameters (dictionary size and
match length limit) as shown in the table below. The default compression
level is <samp><span class="option">-6</span></samp>, equivalent to <samp><span class="option">-s8MiB&nbsp;-m36</span></samp><!-- /@w -->. Note that
<samp><span class="option">-9</span></samp> can be much slower than <samp><span class="option">-0</span></samp>. These options have no
effect when decompressing or testing.

     <p>The bidimensional parameter space of LZMA can't be mapped to a linear scale
optimal for all files. If your files are large, very repetitive, etc, you
may need to use the options <samp><span class="option">--dictionary-size</span></samp> and
<samp><span class="option">--match-length</span></samp> directly to achieve optimal performance.

     </p><p>If several compression levels or <samp><span class="option">-s</span></samp> or <samp><span class="option">-m</span></samp> options are
given, the last setting is used. For example <samp><span class="option">-9&nbsp;-s64MiB</span></samp><!-- /@w --> is
equivalent to <samp><span class="option">-s64MiB&nbsp;-m273</span></samp><!-- /@w -->

     </p><p><table summary=""><tbody><tr align="left"><td valign="top">Level </td><td valign="top">Dictionary size (-s) </td><td valign="top">Match length limit (-m)
<br></td></tr><tr align="left"><td valign="top">-0 </td><td valign="top">64 KiB </td><td valign="top">16 bytes
<br></td></tr><tr align="left"><td valign="top">-1 </td><td valign="top">1 MiB </td><td valign="top">5 bytes
<br></td></tr><tr align="left"><td valign="top">-2 </td><td valign="top">1.5 MiB </td><td valign="top">6 bytes
<br></td></tr><tr align="left"><td valign="top">-3 </td><td valign="top">2 MiB </td><td valign="top">8 bytes
<br></td></tr><tr align="left"><td valign="top">-4 </td><td valign="top">3 MiB </td><td valign="top">12 bytes
<br></td></tr><tr align="left"><td valign="top">-5 </td><td valign="top">4 MiB </td><td valign="top">20 bytes
<br></td></tr><tr align="left"><td valign="top">-6 </td><td valign="top">8 MiB </td><td valign="top">36 bytes
<br></td></tr><tr align="left"><td valign="top">-7 </td><td valign="top">16 MiB </td><td valign="top">68 bytes
<br></td></tr><tr align="left"><td valign="top">-8 </td><td valign="top">24 MiB </td><td valign="top">132 bytes
<br></td></tr><tr align="left"><td valign="top">-9 </td><td valign="top">32 MiB </td><td valign="top">273 bytes
     <br></td></tr></tbody></table>

     <br></p></dd><dt><code>--fast</code></dt><dt><code>--best</code></dt><dd>Aliases for GNU gzip compatibility.

     <br></dd><dt><code>--loose-trailing</code></dt><dd>When decompressing or testing, allow trailing data whose first bytes are
so similar to the magic bytes of a lzip header that they can be confused
with a corrupt header. Use this option if a file triggers a "corrupt
header" error and the cause is not indeed a corrupt header.

     <br></dd><dt><code>--check-lib</code></dt><dd>Compare the <a href="#Library-version">version of lzlib</a> used to compile
minilzip with the version actually being used at run time and exit. Report
any differences found. Exit with error status 1 if differences are found. A
mismatch may indicate that lzlib is not correctly installed or that a
different version of lzlib has been installed after compiling the shared
version of minilzip. Exit with error status 2 if LZ_API_VERSION and
LZ_version_string don't match. '<samp><span class="samp">minilzip&nbsp;-v&nbsp;--check-lib</span></samp>'<!-- /@w --> shows the
version of lzlib being used and the value of LZ_API_VERSION (if defined).

   </dd></dl>

   <p>Numbers given as arguments to options may be expressed in decimal,
hexadecimal, or octal (using the same syntax as integer constants in C++),
and may be followed by a multiplier and an optional '<samp><span class="samp">B</span></samp>' for "byte".

   </p><p>Table of SI and binary prefixes (unit multipliers):

   </p><p><table summary=""><tbody><tr align="left"><td valign="top">Prefix </td><td valign="top">Value               </td><td valign="top">| </td><td valign="top">Prefix </td><td valign="top">Value
<br></td></tr><tr align="left"><td valign="top">k </td><td valign="top">kilobyte   (10^3 = 1000) </td><td valign="top">| </td><td valign="top">Ki </td><td valign="top">kibibyte  (2^10 = 1024)
<br></td></tr><tr align="left"><td valign="top">M </td><td valign="top">megabyte   (10^6)        </td><td valign="top">| </td><td valign="top">Mi </td><td valign="top">mebibyte  (2^20)
<br></td></tr><tr align="left"><td valign="top">G </td><td valign="top">gigabyte   (10^9)        </td><td valign="top">| </td><td valign="top">Gi </td><td valign="top">gibibyte  (2^30)
<br></td></tr><tr align="left"><td valign="top">T </td><td valign="top">terabyte   (10^12)       </td><td valign="top">| </td><td valign="top">Ti </td><td valign="top">tebibyte  (2^40)
<br></td></tr><tr align="left"><td valign="top">P </td><td valign="top">petabyte   (10^15)       </td><td valign="top">| </td><td valign="top">Pi </td><td valign="top">pebibyte  (2^50)
<br></td></tr><tr align="left"><td valign="top">E </td><td valign="top">exabyte    (10^18)       </td><td valign="top">| </td><td valign="top">Ei </td><td valign="top">exbibyte  (2^60)
<br></td></tr><tr align="left"><td valign="top">Z </td><td valign="top">zettabyte  (10^21)       </td><td valign="top">| </td><td valign="top">Zi </td><td valign="top">zebibyte  (2^70)
<br></td></tr><tr align="left"><td valign="top">Y </td><td valign="top">yottabyte  (10^24)       </td><td valign="top">| </td><td valign="top">Yi </td><td valign="top">yobibyte  (2^80)
<br></td></tr><tr align="left"><td valign="top">R </td><td valign="top">ronnabyte  (10^27)       </td><td valign="top">| </td><td valign="top">Ri </td><td valign="top">robibyte  (2^90)
<br></td></tr><tr align="left"><td valign="top">Q </td><td valign="top">quettabyte (10^30)       </td><td valign="top">| </td><td valign="top">Qi </td><td valign="top">quebibyte (2^100)
   <br></td></tr></tbody></table>

   </p><pre class="sp">
</pre>
Exit status: 0 for a normal exit, 1 for environmental problems
(file not found, invalid command-line options, I/O errors, etc), 2 to
indicate a corrupt or invalid input file, 3 for an internal consistency
error (e.g., bug) which caused minilzip to panic.

<div class="node">
<a name="Data-format"></a>
<p></p><hr>
Next:&nbsp;<a rel="next" accesskey="n" href="#Examples">Examples</a>,
Previous:&nbsp;<a rel="previous" accesskey="p" href="#Invoking-minilzip">Invoking minilzip</a>,
Up:&nbsp;<a rel="up" accesskey="u" href="#Top">Top</a>

</div>

<h2 class="chapter">10 Data format</h2>

<p><a name="index-data-format-63"></a>
Perfection is reached, not when there is no longer anything to add, but
when there is no longer anything to take away.<br>
-- Antoine de Saint-Exupery

   </p><pre class="sp">
</pre>
In the diagram below, a box like this:

<pre class="verbatim">+---+
|   | &lt;-- the vertical bars might be missing
+---+
</pre>

   <p>represents one byte; a box like this:

</p><pre class="verbatim">+==============+
|              |
+==============+
</pre>

   <p>represents a variable number of bytes.

   </p><pre class="sp">
</pre>
Lzip data consist of one or more independent "members" (compressed data
sets). The members simply appear one after another in the data stream, with
no additional information before, between, or after them. Each member can
encode in compressed form up to 16&nbsp;EiB&nbsp;-&nbsp;1&nbsp;byte<!-- /@w --> of uncompressed data. 
The size of a multimember data stream is unlimited.

   <p>Each member has the following structure:

</p><pre class="verbatim">+--+--+--+--+----+----+=============+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
| ID string | VN | DS | LZMA stream | CRC32 |   Data size   |  Member size  |
+--+--+--+--+----+----+=============+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
</pre>

   <p>All multibyte values are stored in little endian order.

     </p><dl>
<dt>'<samp><span class="samp">ID string (the "magic" bytes)</span></samp>'</dt><dd>A four byte string, identifying the lzip format, with the value "LZIP"
(0x4C, 0x5A, 0x49, 0x50).

     <br></dd><dt>'<samp><span class="samp">VN (version number, 1 byte)</span></samp>'</dt><dd>Just in case something needs to be modified in the future. 1 for now.

     <p><a name="coded_002ddict_002dsize"></a><br></p></dd><dt>'<samp><span class="samp">DS (coded dictionary size, 1 byte)</span></samp>'</dt><dd>The dictionary size is calculated by taking a power of 2 (the base size)
and subtracting from it a fraction between 0/16 and 7/16 of the base size.<br>
Bits 4-0 contain the base 2 logarithm of the base size (12 to 29).<br>
Bits 7-5 contain the numerator of the fraction (0 to 7) to subtract
from the base size to obtain the dictionary size.<br>
Example: 0xD3 = 2^19 - 6 * 2^15 = 512 KiB - 6 * 32 KiB = 320 KiB<br>
Valid values for dictionary size range from 4 KiB to 512 MiB.

     <br></dd><dt>'<samp><span class="samp">LZMA stream</span></samp>'</dt><dd>The LZMA stream, finished by an "End Of Stream" marker. Uses default values
for encoder properties. 
See
<a href="http://www.nongnu.org/lzip/manual/lzip_manual.html#Stream-format">Stream format</a>
for a complete description.<br>
Lzip only uses the LZMA marker '<samp><span class="samp">2</span></samp>' ("End Of Stream" marker). Lzlib
also uses the LZMA marker '<samp><span class="samp">3</span></samp>' ("Sync Flush" marker). See <a href="#sync_005fflush">sync_flush</a>.

     <br></dd><dt>'<samp><span class="samp">CRC32 (4 bytes)</span></samp>'</dt><dd>Cyclic Redundancy Check (CRC) of the original uncompressed data.

     <br></dd><dt>'<samp><span class="samp">Data size (8 bytes)</span></samp>'</dt><dd>Size of the original uncompressed data.

     <br></dd><dt>'<samp><span class="samp">Member size (8 bytes)</span></samp>'</dt><dd>Total size of the member, including header and trailer. This field acts
as a distributed index, improves the checking of stream integrity, and
facilitates the safe recovery of undamaged members from multimember files. 
Lzip limits the member size to 2&nbsp;PiB<!-- /@w --> to prevent the data size field from
overflowing.

   </dd></dl>

<div class="node">
<a name="Examples"></a>
<p></p><hr>
Next:&nbsp;<a rel="next" accesskey="n" href="#Problems">Problems</a>,
Previous:&nbsp;<a rel="previous" accesskey="p" href="#Data-format">Data format</a>,
Up:&nbsp;<a rel="up" accesskey="u" href="#Top">Top</a>

</div>

<h2 class="chapter">11 A small tutorial with examples</h2>

<p><a name="index-examples-64"></a>
This chapter provides real code examples for the most common uses of the
library. See these examples in context in the files '<samp><span class="samp">bbexample.c</span></samp>' and
'<samp><span class="samp">ffexample.c</span></samp>' from the source distribution of lzlib.

   </p><p>Note that the interface of lzlib is symmetrical. That is, the code for
normal compression and decompression is identical except because one calls
LZ_compress* functions while the other calls LZ_decompress* functions.

</p><ul class="menu">
<li><a accesskey="1" href="#Buffer-compression">Buffer compression</a>:     Buffer-to-buffer single-member compression
</li><li><a accesskey="2" href="#Buffer-decompression">Buffer decompression</a>:   Buffer-to-buffer decompression
</li><li><a accesskey="3" href="#File-compression">File compression</a>:       File-to-file single-member compression
</li><li><a accesskey="4" href="#File-decompression">File decompression</a>:     File-to-file decompression
</li><li><a accesskey="5" href="#File-compression-mm">File compression mm</a>:    File-to-file multimember compression
</li><li><a accesskey="6" href="#Skipping-data-errors">Skipping data errors</a>:   Decompression with automatic resynchronization
</li></ul>

<div class="node">
<a name="Buffer-compression"></a>
<p></p><hr>
Next:&nbsp;<a rel="next" accesskey="n" href="#Buffer-decompression">Buffer decompression</a>,
Up:&nbsp;<a rel="up" accesskey="u" href="#Examples">Examples</a>

</div>

<h3 class="section">11.1 Buffer compression</h3>

<p><a name="index-buffer-compression-65"></a>
Buffer-to-buffer single-member compression
(<var>member_size</var>&nbsp;&gt;&nbsp;total&nbsp;output)<!-- /@w -->.

</p><pre class="verbatim">/* Compress 'insize' bytes from 'inbuf' to 'outbuf'.
   Return the size of the compressed data in '*outlenp'.
   In case of error, or if 'outsize' is too small, return false and do not
   modify '*outlenp'.
*/
bool bbcompress( const uint8_t * const inbuf, const int insize,
                 const int dictionary_size, const int match_len_limit,
                 uint8_t * const outbuf, const int outsize,
                 int * const outlenp )
  {
  int inpos = 0, outpos = 0;
  bool error = false;
  struct LZ_Encoder * const encoder =
    LZ_compress_open( dictionary_size, match_len_limit, INT64_MAX );
  if( !encoder || LZ_compress_errno( encoder ) != LZ_ok )
    { LZ_compress_close( encoder ); return false; }

  while( true )
    {
    int ret = LZ_compress_write( encoder, inbuf + inpos, insize - inpos );
    if( ret &lt; 0 ) { error = true; break; }
    inpos += ret;
    if( inpos &gt;= insize ) LZ_compress_finish( encoder );
    ret = LZ_compress_read( encoder, outbuf + outpos, outsize - outpos );
    if( ret &lt; 0 ) { error = true; break; }
    outpos += ret;
    if( LZ_compress_finished( encoder ) == 1 ) break;
    if( outpos &gt;= outsize ) { error = true; break; }
    }

  if( LZ_compress_close( encoder ) &lt; 0 ) error = true;
  if( error ) return false;
  *outlenp = outpos;
  return true;
  }
</pre>

<div class="node">
<a name="Buffer-decompression"></a>
<p></p><hr>
Next:&nbsp;<a rel="next" accesskey="n" href="#File-compression">File compression</a>,
Previous:&nbsp;<a rel="previous" accesskey="p" href="#Buffer-compression">Buffer compression</a>,
Up:&nbsp;<a rel="up" accesskey="u" href="#Examples">Examples</a>

</div>

<h3 class="section">11.2 Buffer decompression</h3>

<p><a name="index-buffer-decompression-66"></a>
Buffer-to-buffer decompression.

</p><pre class="verbatim">/* Decompress 'insize' bytes from 'inbuf' to 'outbuf'.
   Return the size of the decompressed data in '*outlenp'.
   In case of error, or if 'outsize' is too small, return false and do not
   modify '*outlenp'.
*/
bool bbdecompress( const uint8_t * const inbuf, const int insize,
                   uint8_t * const outbuf, const int outsize,
                   int * const outlenp )
  {
  int inpos = 0, outpos = 0;
  bool error = false;
  struct LZ_Decoder * const decoder = LZ_decompress_open();
  if( !decoder || LZ_decompress_errno( decoder ) != LZ_ok )
    { LZ_decompress_close( decoder ); return false; }

  while( true )
    {
    int ret = LZ_decompress_write( decoder, inbuf + inpos, insize - inpos );
    if( ret &lt; 0 ) { error = true; break; }
    inpos += ret;
    if( inpos &gt;= insize ) LZ_decompress_finish( decoder );
    ret = LZ_decompress_read( decoder, outbuf + outpos, outsize - outpos );
    if( ret &lt; 0 ) { error = true; break; }
    outpos += ret;
    if( LZ_decompress_finished( decoder ) == 1 ) break;
    if( outpos &gt;= outsize ) { error = true; break; }
    }

  if( LZ_decompress_close( decoder ) &lt; 0 ) error = true;
  if( error ) return false;
  *outlenp = outpos;
  return true;
  }
</pre>

<div class="node">
<a name="File-compression"></a>
<p></p><hr>
Next:&nbsp;<a rel="next" accesskey="n" href="#File-decompression">File decompression</a>,
Previous:&nbsp;<a rel="previous" accesskey="p" href="#Buffer-decompression">Buffer decompression</a>,
Up:&nbsp;<a rel="up" accesskey="u" href="#Examples">Examples</a>

</div>

<h3 class="section">11.3 File compression</h3>

<p><a name="index-file-compression-67"></a>
File-to-file compression using LZ_compress_write_size.

</p><pre class="verbatim">int ffcompress( struct LZ_Encoder * const encoder,
                FILE * const infile, FILE * const outfile )
  {
  enum { buffer_size = 16384 };
  uint8_t buffer[buffer_size];
  while( true )
    {
    int len, ret;
    int size = min( buffer_size, LZ_compress_write_size( encoder ) );
    if( size &gt; 0 )
      {
      len = fread( buffer, 1, size, infile );
      ret = LZ_compress_write( encoder, buffer, len );
      if( ret &lt; 0 || ferror( infile ) ) break;
      if( feof( infile ) ) LZ_compress_finish( encoder );
      }
    ret = LZ_compress_read( encoder, buffer, buffer_size );
    if( ret &lt; 0 ) break;
    len = fwrite( buffer, 1, ret, outfile );
    if( len &lt; ret ) break;
    if( LZ_compress_finished( encoder ) == 1 ) return 0;
    }
  return 1;
  }
</pre>

<div class="node">
<a name="File-decompression"></a>
<p></p><hr>
Next:&nbsp;<a rel="next" accesskey="n" href="#File-compression-mm">File compression mm</a>,
Previous:&nbsp;<a rel="previous" accesskey="p" href="#File-compression">File compression</a>,
Up:&nbsp;<a rel="up" accesskey="u" href="#Examples">Examples</a>

</div>

<h3 class="section">11.4 File decompression</h3>

<p><a name="index-file-decompression-68"></a>
File-to-file decompression using LZ_decompress_write_size.

</p><pre class="verbatim">int ffdecompress( struct LZ_Decoder * const decoder,
                  FILE * const infile, FILE * const outfile )
  {
  enum { buffer_size = 16384 };
  uint8_t buffer[buffer_size];
  while( true )
    {
    int len, ret;
    int size = min( buffer_size, LZ_decompress_write_size( decoder ) );
    if( size &gt; 0 )
      {
      len = fread( buffer, 1, size, infile );
      ret = LZ_decompress_write( decoder, buffer, len );
      if( ret &lt; 0 || ferror( infile ) ) break;
      if( feof( infile ) ) LZ_decompress_finish( decoder );
      }
    ret = LZ_decompress_read( decoder, buffer, buffer_size );
    if( ret &lt; 0 ) break;
    len = fwrite( buffer, 1, ret, outfile );
    if( len &lt; ret ) break;
    if( LZ_decompress_finished( decoder ) == 1 ) return 0;
    }
  return 1;
  }
</pre>

<div class="node">
<a name="File-compression-mm"></a>
<p></p><hr>
Next:&nbsp;<a rel="next" accesskey="n" href="#Skipping-data-errors">Skipping data errors</a>,
Previous:&nbsp;<a rel="previous" accesskey="p" href="#File-decompression">File decompression</a>,
Up:&nbsp;<a rel="up" accesskey="u" href="#Examples">Examples</a>

</div>

<h3 class="section">11.5 File-to-file multimember compression</h3>

<p><a name="index-multimember-compression-69"></a>
Example 1: Multimember compression with members of fixed size
(<var>member_size</var>&nbsp;&lt;&nbsp;total&nbsp;output)<!-- /@w -->.

</p><pre class="verbatim">int ffmmcompress( FILE * const infile, FILE * const outfile )
  {
  enum { buffer_size = 16384, member_size = 4096 };
  uint8_t buffer[buffer_size];
  bool done = false;
  struct LZ_Encoder * const encoder =
    LZ_compress_open( 65535, 16, member_size );
  if( !encoder || LZ_compress_errno( encoder ) != LZ_ok  )
    { fputs( "ffexample: Not enough memory.\n", stderr );
      LZ_compress_close( encoder ); return 1; }
  while( true )
    {
    int len, ret;
    int size = min( buffer_size, LZ_compress_write_size( encoder ) );
    if( size &gt; 0 )
      {
      len = fread( buffer, 1, size, infile );
      ret = LZ_compress_write( encoder, buffer, len );
      if( ret &lt; 0 || ferror( infile ) ) break;
      if( feof( infile ) ) LZ_compress_finish( encoder );
      }
    ret = LZ_compress_read( encoder, buffer, buffer_size );
    if( ret &lt; 0 ) break;
    len = fwrite( buffer, 1, ret, outfile );
    if( len &lt; ret ) break;
    if( LZ_compress_member_finished( encoder ) == 1 )
      {
      if( LZ_compress_finished( encoder ) == 1 ) { done = true; break; }
      if( LZ_compress_restart_member( encoder, member_size ) &lt; 0 ) break;
      }
    }
  if( LZ_compress_close( encoder ) &lt; 0 ) done = false;
  return done;
  }
</pre>

   <pre class="sp">
</pre>
Example 2: Multimember compression (user-restarted members). 
(Call LZ_compress_open with <var>member_size</var> &gt; largest member).

<pre class="verbatim">/* Compress 'infile' to 'outfile' as a multimember stream with one member
   for each line of text terminated by a newline character or by EOF.
   Return 0 if success, 1 if error.
*/
int fflfcompress( struct LZ_Encoder * const encoder,
                  FILE * const infile, FILE * const outfile )
  {
  enum { buffer_size = 16384 };
  uint8_t buffer[buffer_size];
  while( true )
    {
    int len, ret;
    int size = min( buffer_size, LZ_compress_write_size( encoder ) );
    if( size &gt; 0 )
      {
      for( len = 0; len &lt; size; )
        {
        int ch = getc( infile );
        if( ch == EOF || ( buffer[len++] = ch ) == '\n' ) break;
        }
      /* avoid writing an empty member to outfile */
      if( len == 0 &amp;&amp; LZ_compress_data_position( encoder ) == 0 ) return 0;
      ret = LZ_compress_write( encoder, buffer, len );
      if( ret &lt; 0 || ferror( infile ) ) break;
      if( feof( infile ) || buffer[len-1] == '\n' )
        LZ_compress_finish( encoder );
      }
    ret = LZ_compress_read( encoder, buffer, buffer_size );
    if( ret &lt; 0 ) break;
    len = fwrite( buffer, 1, ret, outfile );
    if( len &lt; ret ) break;
    if( LZ_compress_member_finished( encoder ) == 1 )
      {
      if( feof( infile ) &amp;&amp; LZ_compress_finished( encoder ) == 1 ) return 0;
      if( LZ_compress_restart_member( encoder, INT64_MAX ) &lt; 0 ) break;
      }
    }
  return 1;
  }
</pre>

<div class="node">
<a name="Skipping-data-errors"></a>
<p></p><hr>
Previous:&nbsp;<a rel="previous" accesskey="p" href="#File-compression-mm">File compression mm</a>,
Up:&nbsp;<a rel="up" accesskey="u" href="#Examples">Examples</a>

</div>

<h3 class="section">11.6 Skipping data errors</h3>

<p><a name="index-skipping-data-errors-70"></a>
</p><pre class="verbatim">/* Decompress 'infile' to 'outfile' with automatic resynchronization to
   next member in case of data error, including the automatic removal of
   leading garbage.
*/
int ffrsdecompress( struct LZ_Decoder * const decoder,
                    FILE * const infile, FILE * const outfile )
  {
  enum { buffer_size = 16384 };
  uint8_t buffer[buffer_size];
  while( true )
    {
    int len, ret;
    int size = min( buffer_size, LZ_decompress_write_size( decoder ) );
    if( size &gt; 0 )
      {
      len = fread( buffer, 1, size, infile );
      ret = LZ_decompress_write( decoder, buffer, len );
      if( ret &lt; 0 || ferror( infile ) ) break;
      if( feof( infile ) ) LZ_decompress_finish( decoder );
      }
    ret = LZ_decompress_read( decoder, buffer, buffer_size );
    if( ret &lt; 0 )
      {
      if( LZ_decompress_errno( decoder ) == LZ_header_error ||
          LZ_decompress_errno( decoder ) == LZ_data_error )
        { LZ_decompress_sync_to_member( decoder ); continue; }
      break;
      }
    len = fwrite( buffer, 1, ret, outfile );
    if( len &lt; ret ) break;
    if( LZ_decompress_finished( decoder ) == 1 ) return 0;
    }
  return 1;
  }
</pre>

<div class="node">
<a name="Problems"></a>
<p></p><hr>
Next:&nbsp;<a rel="next" accesskey="n" href="#Concept-index">Concept index</a>,
Previous:&nbsp;<a rel="previous" accesskey="p" href="#Examples">Examples</a>,
Up:&nbsp;<a rel="up" accesskey="u" href="#Top">Top</a>

</div>

<h2 class="chapter">12 Reporting bugs</h2>

<p><a name="index-bugs-71"></a><a name="index-getting-help-72"></a>
There are probably bugs in lzlib. There are certainly errors and
omissions in this manual. If you report them, they will get fixed. If
you don't, no one will ever know about them and they will remain unfixed
for all eternity, if not longer.

   </p><p>If you find a bug in lzlib, please send electronic mail to
<a href="mailto:lzip-bug@nongnu.org">lzip-bug@nongnu.org</a>. Include the version number, which you can
find by running '<samp><span class="samp">minilzip&nbsp;--version</span></samp>'<!-- /@w --> and
'<samp><span class="samp">minilzip&nbsp;-v&nbsp;--check-lib</span></samp>'<!-- /@w -->.

</p><div class="node">
<a name="Concept-index"></a>
<p></p><hr>
Previous:&nbsp;<a rel="previous" accesskey="p" href="#Problems">Problems</a>,
Up:&nbsp;<a rel="up" accesskey="u" href="#Top">Top</a>

</div>

<h2 class="unnumbered">Concept index</h2>

<ul class="index-cp" compact="compact">
<li><a href="#index-buffer-compression-65">buffer compression</a>: <a href="#Buffer-compression">Buffer compression</a></li>
<li><a href="#index-buffer-decompression-66">buffer decompression</a>: <a href="#Buffer-decompression">Buffer decompression</a></li>
<li><a href="#index-buffering-7">buffering</a>: <a href="#Buffering">Buffering</a></li>
<li><a href="#index-bugs-71">bugs</a>: <a href="#Problems">Problems</a></li>
<li><a href="#index-compression-functions-15">compression functions</a>: <a href="#Compression-functions">Compression functions</a></li>
<li><a href="#index-data-format-63">data format</a>: <a href="#Data-format">Data format</a></li>
<li><a href="#index-decompression-functions-31">decompression functions</a>: <a href="#Decompression-functions">Decompression functions</a></li>
<li><a href="#index-error-codes-50">error codes</a>: <a href="#Error-codes">Error codes</a></li>
<li><a href="#index-error-messages-59">error messages</a>: <a href="#Error-messages">Error messages</a></li>
<li><a href="#index-examples-64">examples</a>: <a href="#Examples">Examples</a></li>
<li><a href="#index-file-compression-67">file compression</a>: <a href="#File-compression">File compression</a></li>
<li><a href="#index-file-decompression-68">file decompression</a>: <a href="#File-decompression">File decompression</a></li>
<li><a href="#index-getting-help-72">getting help</a>: <a href="#Problems">Problems</a></li>
<li><a href="#index-introduction-1">introduction</a>: <a href="#Introduction">Introduction</a></li>
<li><a href="#index-invoking-61">invoking</a>: <a href="#Invoking-minilzip">Invoking minilzip</a></li>
<li><a href="#index-library-version-2">library version</a>: <a href="#Library-version">Library version</a></li>
<li><a href="#index-multimember-compression-69">multimember compression</a>: <a href="#File-compression-mm">File compression mm</a></li>
<li><a href="#index-options-62">options</a>: <a href="#Invoking-minilzip">Invoking minilzip</a></li>
<li><a href="#index-parameter-limits-8">parameter limits</a>: <a href="#Parameter-limits">Parameter limits</a></li>
<li><a href="#index-skipping-data-errors-70">skipping data errors</a>: <a href="#Skipping-data-errors">Skipping data errors</a></li>
</ul>


</body></html>
<!--

Local Variables:
coding: iso-8859-15
End:

-->