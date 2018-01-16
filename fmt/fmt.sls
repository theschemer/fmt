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

(library (fmt)
  (export new-fmt-state
          fmt fmt-start fmt-if fmt-capture fmt-let fmt-bind fmt-null
          fmt-ref fmt-set! fmt-add-properties! fmt-set-property!
          fmt-col fmt-set-col! fmt-row fmt-set-row!
          fmt-radix fmt-set-radix! fmt-precision fmt-set-precision!
          fmt-properties fmt-set-properties! fmt-width fmt-set-width!
          fmt-writer fmt-set-writer! fmt-port fmt-set-port!
          fmt-decimal-sep fmt-set-decimal-sep!
          copy-fmt-state
          fmt-file fmt-try-fit cat apply-cat nl fl nl-str
          fmt-join fmt-join/last fmt-join/dot
          fmt-join/prefix fmt-join/suffix fmt-join/range
          pad pad/right pad/left pad/both trim trim/left trim/both trim/length
          fit fit/left fit/both tab-to space-to wrt wrt/unshared dsp
          pretty pretty/unshared slashified maybe-slashified
          num num/si num/fit num/comma radix fix decimal-align ellipses
          num/roman num/old-roman
          upcase downcase titlecase pad-char comma-char decimal-char
          with-width wrap-lines fold-lines justify
          make-string-fmt-transformer
          make-space make-nl-space display-to-string write-to-string
          fmt-columns columnar tabular line-numbers
          mantissa+exponent)
  (import (except (rnrs base) error)
          (except (rnrs lists) fold-left)
          (rnrs mutable-pairs)
          (rnrs io simple)
          (rnrs io ports)
          (rnrs control)
          (rnrs unicode)
          (rnrs r5rs)
          (only (chezscheme) include open-output-string get-output-string)
          (only (srfi :1) make-list length+ fold)
          (only (srfi :13) string-count string-index-right string-concatenate-reverse
                string-index substring/shared reverse-list->string string-suffix?
                string-prefix? string-concatenate)
          (srfi :69)
          (srfi :23))

  (define read-line
    (case-lambda
      (() (get-line (current-input-port)))
      ((p) (get-line p))))

  (define (call-with-output-string proc)
    (let ((port (open-output-string)))
      (proc port)
      (get-output-string port)))

  (define (make-eq?-table) (make-hash-table eq?))

  (include "let-optionals.scm")

  (define (mantissa+exponent num . opt)
    (if (zero? num)
        (list 0 0)
        (let-optionals* opt ((base 2) (mant-size 52) (exp-size 11))
                        (let* ((bot (expt base mant-size))
                               (top (* base bot)))
                          (let lp ((n num) (e 0))
                            (cond
                             ((>= n top) (lp (quotient n base) (+ e 1)))
                             ((< n bot) (lp (* n base) (- e 1)))
                             (else (list n e))))))))


  (include "fmt.scm")
  (include "fmt-pretty.scm")

  ;; Override string-tokenize (which does not support unicode on Chicken)
  ;; and use string-split so utf8 byte sequences are not treated as whitespace.
  (define (string-tokenize s)
    (string-split s))
  (include "fmt-column.scm")

  (include "fmt-utils.chezscheme.sls")
  
  )
