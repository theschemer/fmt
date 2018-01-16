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

(define compose
  (lambda (f g)
    (lambda x
      (f (apply g x)))))

;;; The following definitions have the indicated license and origin.

;; Copyright 2009 Derick Eddington.  My MIT-style license is in the file named
;; LICENSE from the original collection this file is distributed with.

;; from https://github.com/stuhlmueller/scheme-tools/blob/master/xitomatl/lists.sls
(define (intersperse l sep)
  (let loop ((l l) (r '()) (sep sep) (orig l))
    (cond ((pair? l) (loop (cdr l) (cons* sep (car l) r) sep orig))
          ((null? l) (if (null? r) '() (reverse (cdr r))))
          (else (error "not a proper list" orig)))))

;; from https://github.com/stuhlmueller/scheme-tools/blob/master/xitomatl/strings.sls
(define (string-intersperse sl ssep)
  (apply string-append (intersperse sl ssep)))

(define whitespace 
  (apply string
         '(#\space #\linefeed #\return #\tab #\vtab #\page #\x85 #\xA0 
           #\x1680 #\x180E #\x2000 #\x2001 #\x2002 #\x2003 #\x2004 #\x2005
           #\x2006 #\x2007 #\x2008 #\x2009 #\x200A #\x2028 #\x2029 #\x202F
           #\x205F #\x3000)))

(define string-split
  (case-lambda
    ((str) 
     (string-split str whitespace #F))
    ((str delim-chars)
     (string-split str delim-chars #F))
    ((str delim-chars keep-empty)
     (unless (and (string? str) (string? delim-chars))
       (assertion-violation 'string-split "not a string" 
                            (if (string? delim-chars) str delim-chars)))
     (let ((strlen (string-length str))
           (dellen (string-length delim-chars)))
       (let loop ((i (- strlen 1))
                  (to strlen)
                  (accum '()))
         (if (< i 0)
             (if (or (< 0 to) keep-empty)
                 (cons (substring str 0 to) accum)
                 accum)
             (let ((c (string-ref str i)))
               (let check ((j 0))
                 (cond ((= j dellen) (loop (- i 1) to accum))
                       ((char=? c (string-ref delim-chars j))
                        (loop (- i 1) i (let ((i+1 (+ i 1)))
                                          (if (or (< i+1 to) keep-empty)
                                              (cons (substring str i+1 to) accum)
                                              accum))))
                       (else (check (+ j 1))))))))))))
