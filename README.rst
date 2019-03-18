==================
Saleor Boilerplate
==================

`Divio Cloud <http://www.divio.com/>`_ based boilerplate to develop with Saleor.

Up to date with `Saleor <https://getsaleor.com/>`_ **2.4.0**


==========
Aldryn SSO
==========

When you are using Saleor with Divio Cloud then you are able to use ``aldryn-sso`` 
available under url: ``/<lang>/login/`` to sign in using your Divio Cloud credentials. 
The default Saleor form is still available to use.

To set ``aldryn-sso`` login form as default, change ``LOGIN_URL`` in your settings to ``'aldryn_sso_login'``.

You can disable this functionality by removing ``aldryn-sso`` from ``INSTALLED_ADDONS`` in ``settings.py``.


=============
Sending email
=============

You need to configure your project to be able to send email. You should set `EMAIL_URL` as your env variable.

You will find more information about this on `dj-email-url package <https://github.com/migonzalvar/dj-email-url>`_.

Check our article about how to achieve it:
`Sending email in Divio Cloud applications <https://docs.divio.com/en/latest/reference/coding-sending-email.html>`_

When you are using external SMTP it should look like:
``submission://smtp_user:smtp_pass@smtp_host:port``


============
Contribution
============

You are very welcome improving this boilerplate for your everyday use. Feel free to fork and send us pull requests.

See `Saleor Official Documentation <https://docs.getsaleor.com/en/latest/>`_ for further information.
