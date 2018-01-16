;;; Copyright (c) 2016 Federico Beffa All rights reserved.
;;;
;;; Redistribution and use in source and binary forms, with or without
;;; modification, are permitted provided that the following conditions
;;; are met:
;;; 1. Redistributions of source code must retain the above copyright
;;;    notice, this list of conditions and the following disclaimer.
;;; 2. Redistributions in binary form must reproduce the above copyright
;;;    notice, this list of conditions and the following disclaimer in the
;;;    documentation and/or other materials provided with the distribution.
;;; 3. The name of the author may not be used to endorse or promote products
;;;    derived from this software without specific prior written permission.
;;;
;;; THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
;;; IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
;;; OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
;;; IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
;;; INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
;;; NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICESLOSS OF USE,
;;; DATA, OR PROFITSOR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
;;; THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
;;; (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
;;; THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

(library (fmt-c)
  (export fmt-in-macro? fmt-expression? fmt-return? fmt-default-type
          fmt-newline-before-brace? fmt-braceless-bodies?
          fmt-indent-space fmt-switch-indent-space fmt-op fmt-gen
          c-in-expr c-in-stmt c-in-test
          c-paren c-maybe-paren c-type c-literal? c-literal char->c-char
          c-struct c-union c-class c-enum c-typedef c-cast
          c-expr c-expr/sexp c-apply c-op c-indent c-current-indent-string
          c-wrap-stmt c-open-brace c-close-brace
          c-block c-braced-block c-begin
          c-fun c-var c-prototype c-param c-param-list
          c-while c-for c-if c-switch
          c-case c-case/fallthrough c-default
          c-break c-continue c-return c-goto c-label
          c-static c-const c-extern c-volatile c-auto c-restrict c-inline
          c++ c-- c+ c- c* c/ c% c& c^ c~ c! c&& c<< c>> c== c!= ;  |c\||  |c\|\||
          c< c> c<= c>= c= c+= c-= c*= c/= c%= c&= c^= c<<= c>>= ;++c --c ;  |c\|=|
          c++/post c--/post c. c->
          c-bit-or c-or c-bit-or=
          cpp-if cpp-ifdef cpp-ifndef cpp-elif cpp-endif cpp-else cpp-undef
          cpp-include cpp-define cpp-wrap-header cpp-pragma cpp-line
          cpp-error cpp-warning cpp-stringify cpp-sym-cat
          c-comment c-block-comment c-attribute)
  (import (except (rnrs base) error)
          (except (rnrs lists) fold-left)
          (rnrs io ports)
          (rnrs unicode)
          (only (srfi :1) make-list length+ fold every)
          (only (chezscheme) include)
          (only (srfi :1) every)
          (only (srfi :13) substring/shared string-index-right string-index)
          (srfi :23)
          (fmt))

  (include "fmt-c.scm")

  )
