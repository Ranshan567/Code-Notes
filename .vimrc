au BufNewFile *.[ch],*.[ch]pp exec ":call SetNewFileHeader()"
au BufNewFile *.mk,[Mm]akefile exec ":call SetNewFileHeader()"
au BufNewFile *.sh,*.py exec ":call SetNewFileHeader()"
 
" SetNewFileHeader for new buffer
func SetNewFileHeader()
	" set author_name here
	let $author_name = $USER
 
    if &filetype == 'make'
        call setline(1,  "####################################################")
	call setline(2,  "# Author      : ".$author_name )
        call setline(3,  "# Created date: ".strftime('%F %T'))
        call setline(4,  "# Describe    : " )
        call setline(5,  "####################################################")
        call setline(6,  "")
        call setline(7,  "#target: prerequisites ")
        call setline(8,  "#\tcommand")
        call setline(9,  "")
 
    elseif &filetype == 'sh'
        call setline(1,  "#!/bin/bash")
        call setline(2,  "#PBS -l nodes=2:ppn=20")
        call setline(3,  "#PBS -j oe")
        call setline(4,  "#PBS -V")
        call setline(5,  "#PBS -q workq")
        call setline(6,  "##PBS -N")
        call setline(7,  "####################################################")
        call setline(8,  "# Author      : ".$author_name )
        call setline(9,  "# Created date: ".strftime('%F %T'))
        call setline(10,  "# Describe    : " )
        call setline(11,  "####################################################")
        call setline(12,  "beginTime=`date +%s`")
        call setline(13,  "####################################################")
        call setline(14,  "T=40	# thread")
        call setline(15,  "")
        call setline(16,  "")
        call setline(17,  "")
        call setline(18,  "####################################################")
        call setline(19,  "endTime=`date +%s`")
        call setline(20,  "echo -n '总共耗时: ';time=$(printf '%.5f' `echo \"scale=5;($endTime-$beginTime)/3600\"|bc`);echo -n $time;echo ' 小时'")

    elseif &filetype == 'python'
        call setline(1,  "#! /usr/bin/env python3")
        call setline(2,  "# coding=utf-8")
        call setline(3,  "####################################################")
        call setline(4,  "# Author      : ".$author_name )
        call setline(5,  "# Created date: ".strftime('%F %T'))
        call setline(6,  "# Describe    : " )
        call setline(7,  "####################################################")
        call setline(8,  "")
        call setline(9,  "if __name__ == '__main__':")
        call setline(10,  "    print(\"hello ".expand('%:t')."\")")
        call setline(11, "")
 
    else
	" set title for *.h,*.hpp,*.c,*.cpp
	call setline(1, "/*****************************************")
	call setline(2, " * Copyright (C) ".strftime('%Y')." * Ltd. All rights reserved.")
	call setline(3, " *")
	call setline(4, " * File name   : ".expand('%:t'))
	call setline(5, " * Author      : ".$author_name )
	call setline(6, " * Created date: ".strftime('%F %T'))
	call setline(7, " * Description : ")
	call setline(8, " *")
	call setline(9, " *******************************************/")
	call setline(10,"")

        if expand("%:e") == 'hpp'
            call append(line("$"), "#ifndef __".toupper(expand("%:t:r"))."_H__")
            call append(line("$"), "#define __".toupper(expand("%:t:r"))."_H__")
            call append(line("$"), "")
            call append(line("$"), "#include <iostream>")
            call append(line("$"), "#include <sstream>")
            call append(line("$"), "#include <string>")
            call append(line("$"), "#include <vector>")
            call append(line("$"), "#include <queue>")
            call append(line("$"), "#include <map>")
            call append(line("$"), "#include <memory>")
            call append(line("$"), "#include <algorithm>")
            call append(line("$"), "#include <chrono>")
            call append(line("$"), "#include <atomic>")
            call append(line("$"), "#include <mutex>")
            call append(line("$"), "#include <condition_variable>")
            call append(line("$"), "#include <numeric>")
            call append(line("$"), "#include <functional>")
            call append(line("$"), "#include <future>")
            call append(line("$"), "#include <thread>")
            call append(line("$"), "")
            call append(line("$"), "")
            call append(line("$"), "#endif //__".toupper(expand("%:t:r"))."_H__")
            call append(line("$"), "")
 
        elseif expand("%:e") == 'h'
            call append(line("$"), "//#pragma once")
            call append(line("$"), "#ifndef __".toupper(expand("%:t:r"))."_H__")
            call append(line("$"), "#define __".toupper(expand("%:t:r"))."_H__")
            call append(line("$"), "")
            call append(line("$"), "#include <stdio.h>")
            call append(line("$"), "#include <stdlib.h>")
            call append(line("$"), "#include <string.h>")
            call append(line("$"), "")
            call append(line("$"), "#ifdef __cplusplus")
            call append(line("$"), "extern \"C\"")
            call append(line("$"), "{")
            call append(line("$"), "#endif")
            call append(line("$"), "")
            call append(line("$"), "")
            call append(line("$"), "#ifdef __cplusplus")
            call append(line("$"), "}")
            call append(line("$"), "#endif")
            call append(line("$"), "#endif //__".toupper(expand("%:t:r"))."_H__")
            call append(line("$"), "")
 
        elseif &filetype == 'c'
            call append(line("$"), "#define LOG_TAG \"".toupper(expand("%:t:r"))."\"")
            call append(line("$"), "#include \"".expand("%:t:r").".h\"")
            call append(line("$"), "")
            call append(line("$"), "#include <stdio.h>")
            call append(line("$"), "#include <stdlib.h>")
            call append(line("$"), "#include <string.h>")
            call append(line("$"), "")
            call append(line("$"), "int main(int argc, char *argv[]) {")
            call append(line("$"), "    (void)argc;")
            call append(line("$"), "    (void)argv;")
            call append(line("$"), "")
            call append(line("$"), "    return 0;")
            call append(line("$"), "}")
            call append(line("$"), "")
 
        elseif &filetype == 'cpp'
            call append(line("$"), "#define LOG_TAG \"".toupper(expand("%:t:r"))."\"")
            call append(line("$"), "#include \"".expand("%:t:r").".h\"")
            call append(line("$"), "")
            call append(line("$"), "#include <iostream>")
            call append(line("$"), "#include <sstream>")
            call append(line("$"), "#include <string>")
            call append(line("$"), "#include <vector>")
            call append(line("$"), "#include <queue>")
            call append(line("$"), "#include <map>")
            call append(line("$"), "#include <memory>")
            call append(line("$"), "#include <algorithm>")
            call append(line("$"), "#include <chrono>")
            call append(line("$"), "#include <atomic>")
            call append(line("$"), "#include <mutex>")
            call append(line("$"), "#include <condition_variable>")
            call append(line("$"), "#include <numeric>")
            call append(line("$"), "#include <functional>")
            call append(line("$"), "#include <future>")
            call append(line("$"), "#include <thread>")
            call append(line("$"), "")
            call append(line("$"), "int main(int argc, char *argv[]) {")
            call append(line("$"), "    (void)argc;")
            call append(line("$"), "    (void)argv;")
            call append(line("$"), "")
            call append(line("$"), "    return 0;")
            call append(line("$"), "}")
            call append(line("$"), "")
 
        endif
 
    endif
endfunc
