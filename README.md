Saleor Boilerplate
==================

Divio Cloud based boilerplate to develop with [Saleor](https://getsaleor.com/).

aldryn-sso
----------
When you are using Saleor with Divio Cloud then you are able to use `aldryn-sso` available under url: `/<lang>/login/` to sign in using your Divio Cloud credentials. The default Saleor form is still available to use.

To set `aldryn-sso` login form as default, change `LOGIN_URL` in your settings to `'aldryn_sso_login'`.

You can disable this functionality by removing `aldryn-sso` from `INSTALLED_ADDONS` in settings.py.

celery and emails
-----------------
Sending emails using celery tasks is not working on this configuration.


See [Saleor Official Documentation](https://docs.getsaleor.com/en/latest/) for further information.