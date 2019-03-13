Saleor Boilerplate
==================

Divio Cloud based boilerplate to develop with [Saleor](https://getsaleor.com/).

Aldryn-sso
----------
When you are using Saleor with Divio Cloud then you are able to use `aldryn-sso` available under url: `/<lang>/login/` to sign in using your Divio Cloud credentials. The default Saleor form is still available to use.

To set `aldryn-sso` login form as default, change `LOGIN_URL` in your settings to `'aldryn_sso_login'`.

You can disable this functionality by removing `aldryn-sso` from `INSTALLED_ADDONS` in settings.py.

Sending emails
-----------------
You need to configure your project to be able to send an emails. Check our article about how to achieve it:

[Sending email in Divio Cloud applications](https://docs.divio.com/en/latest/reference/coding-sending-email.html)

Contribution
------------
You are very welcome improving this boilerplate for your everyday use. Feel free to fork and send us pull requests..

See [Saleor Official Documentation](https://docs.getsaleor.com/en/latest/) for further information.