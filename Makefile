# The MIT License (MIT)

# Copyright (c) 2015 Skorezore

# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


ifeq "$(OS)" "Windows_NT"
	CURSES_VARIANT := pd
else
	CURSES_VARIANT := n
endif

ifeq "$(TRAVIS)" "true"
	CXXCIAR := -static-libstdc++ -static-libgcc
else
	CXXCIAR :=
endif


all :
	@mkdir -p binaries 2>nul || :
	$(CXX) $(CXXCIAR) -Os $(foreach src,$(shell ls source | grep .cpp),source/$(src)) -obinaries/gaem -l$(CURSES_VARIANT)curses -std=c++14 -Wall -Wextra -pedantic
	strip --strip-all --remove-section=.comment --remove-section=.note binaries/`ls binaries | grep gaem`
