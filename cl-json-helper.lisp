;;; Copyright (c) 2017 William R. Felts III, All Rights Reserved
;;;
;;; Redistribution and use in source and binary forms, with or without
;;; modification, are permitted provided that the following conditions
;;; are met:
;;;
;;;   * Redistributions of source code must retain the above copyright
;;;     notice, this list of conditions and the following disclaimer.
;;;
;;;   * Redistributions in binary form must reproduce the above
;;;     copyright notice, this list of conditions and the following
;;;     disclaimer in the documentation and/or other materials
;;;     provided with the distribution.
;;;
;;; THIS SOFTWARE IS PROVIDED BY THE AUTHOR 'AS IS' AND ANY EXPRESSED
;;; OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
;;; WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;;; ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
;;; DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
;;; DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
;;; GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;;; INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
;;; WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
;;; NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
;;; SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
;;;
;;;; cl-json-helper.lisp

(in-package #:cl-json-helper)

;;; "cl-json-helper" goes here. Hacks and glory await!

;;; (json-empty) returns an object that cl-json will decode to '{}'
;;; (json-bool val) returns an object that cl-json will decode to "true" or "false"
;;; (json-get-value-with-key key list) returns the value associated with key

(defclass json-empty-obj ()
  ())

(defparameter *json-empty-obj* (make-instance 'json-empty-obj))

(defun json-empty ()
  *json-empty-obj*)

(defclass json-false-obj ()
  ())

(defparameter *json-false-obj* (make-instance 'json-false-obj))

(defmethod json:encode-json ((object json-false-obj) &optional stream)
  (princ "false" stream)
  nil)

(defun json-bool (val)
  (or val *json-false-obj*))

;;;
;;; given a list of ((key1 . value1) (key2 . value2) ...)
;;; find the value associated with key
;;;
;;; returns (value found-p)
;;;
(defun json-key-value (key list &key (test #'eql))
  (let ((item (assoc key list :test test)))
    (if item
	(values (cdr item) t)
	(values nil nil))))
