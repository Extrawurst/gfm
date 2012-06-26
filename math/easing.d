module gfm.math.easing;

// A D port of easing equations from Robert Penner
// http://www.robertpenner.com/easing/

/*

TERMS OF USE - EASING EQUATIONS

Open source under the BSD License. 

Copyright © 2001 Robert Penner
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are 
permitted provided that the following conditions are met:

Redistributions of source code must retain the above copyright notice, this list of 
conditions and the following disclaimer.
Redistributions in binary form must reproduce the above copyright notice, this list 
of conditions and the following disclaimer in the documentation and/or other materials 
provided with the distribution.
Neither the name of the author nor the names of contributors may be used to endorse or 
promote products derived from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY 
EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL 
THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, 
STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF 
THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

*/

import std.math;
import std.traits;

private template makeEasing(string name, string easeInBody)
{
    string makeEasing = 
        r" 
            function easeIn" ~ name ~ r"(T t) if isFloatingPoint!T
            {"
            ~ easeInBody ~ r"
            }

            function easeOut" ~ name ~ r"(T t) if isFloatingPoint!T
            {
                return 1 - easeIn" ~ name ~ r"(1 - t);
            }

            function easeInOut" ~ name ~ r"(T t) if isFloatingPoint!T
            {
                t *= 2;
                if (t < 1)
                    return easeIn" ~ name ~ r"(t) / 2;
                else
                    return 0.5f + easeOut" ~ name ~ r"(t-1) / 2;

            }";
}

mixin makeEasing!("Quad",  "return t*t;");
mixin makeEasing!("Cubic", "return t*t*t;");
mixin makeEasing!("Quart", "return t*t*t*t;");
mixin makeEasing!("Quint", "return t*t*t*t*t;");