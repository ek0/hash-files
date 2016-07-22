(defun println (string)
  (princ string)
  (terpri))

(defun hash-data-md5 (data)
  (secure-hash 'md5 data))

(defun hash-data-sha1 (data)
  (secure-hash 'sha1 data))

(defun hash-data-sha256 (data)
  (secure-hash 'sha256 data))

(defun hash-file-md5 (filename)
  (when (file-regular-p filename)
    (with-temp-buffer
      (insert-file-literally filename)
      (hash-data-md5 (buffer-string)))))

(defun hash-file-sha1 (filename)
  (when (file-regular-p filename)
    (with-temp-buffer
      (insert-file-literally filename)
      (hash-data-sha1 (buffer-string)))))

(defun hash-file-sha256 (filename)
  (when (file-regular-p filename)
    (with-temp-buffer
      (insert-file-literally filename)
      (hash-data-sha256 (buffer-string)))))

(defun hash-dir-md5 (dirname)
  (mapc 'hash-file-md5
	(mapcar (lambda (rel) (concat dirname rel)) (directory-files dirname))))

(defun hash-dir-sha1 (dirname)
  (mapc 'hash-file-sha1
	(mapcar (lambda (rel) (concat dirname rel)) (directory-files dirname))))

(defun hash-dir-sha256 (dirname)
  (mapc 'hash-file-sha256
	(mapcar (lambda (rel) (concat dirname rel)) (directory-files dirname))))

(defun hash-md5 (path)
  (interactive "GPath : ")
  (with-output-to-temp-buffer "*hashes*"
    (if (file-regular-p path)
	(hash-file-md5 path))
    (if (file-directory-p path)
	(hash-dir-md5 path))))

(defun hash-sha1 (path)
  (interactive "GPath : ")
  (with-output-to-temp-buffer "*hashes*"
    (if (file-regular-p path)
	(hash-file-sha1 path))
    (if (file-directory-p path)
	(hash-dir-sha1 path))))

(defun hash-sha256 (path)
  (interactive "GPath : ")
  (with-output-to-temp-buffer "*hashes*"
    (if (file-regular-p path)
	(hash-file-sha256 path))
    (if (file-directory-p path)
	(hash-dir-sha256 path))))

(defun dired-do-hash-md5 (files)
  (interactive (list (dired-get-marked-files)))
  (with-output-to-temp-buffer "*debug*"
    (mapc 'println (mapcar 'hash-file-md5 files))))

(defun dired-do-hash-sha1 (files)
  (interactive (list (dired-get-marked-files)))
  (with-output-to-temp-buffer "*debug*"
    (mapc 'println (mapcar 'hash-file-sha1 files))))

(defun dired-do-hash-sha256 (files)
  (interactive (list (dired-get-marked-files)))
  (with-output-to-temp-buffer "*debug*"
    (mapc 'println (mapcar 'hash-file-sha256 files))))

(defun dired-do-hash-all (files)
  (interactive (list (dired-get-marked-files)))
  (with-output-to-temp-buffer "*hashes*"
    (mapc 'println (mapcar 'hash-file-md5 files))
    (mapc 'println (mapcar 'hash-file-sha1 files))
    (mapc 'println (mapcar 'hash-file-sha256 files))))

(provide 'hash-files)
