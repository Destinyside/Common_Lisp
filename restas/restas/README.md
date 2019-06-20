
#### requirements

- quicklisp
- cl-who
- cl-bootstrap
- cl-css
- cl-json
- cl-dbi

#### steps 

first execute:
```
ln -s /path/to/restas/static /var/www/static
```
and then add the nginx.conf to the nginx configs path and start nginx,
then use one of the follow commands:

- `clisp -i main.lisp`
- `sbcl --load main.lisp`

the default website port is 8081 and the default static files port is 8181.
