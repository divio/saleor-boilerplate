==================
Saleor Boilerplate
==================

`Divio Cloud <http://www.divio.com/>`_ based boilerplate to develop with Saleor.

Up to date with `Saleor <https://getsaleor.com/>`_ **2.9.0**


=============
Configuration
=============


Login
-----

On Divio Cloud, login at ``/login/``.

Then go to the Saleor dashboard at ``/dashboard``.

This will use our ``aldryn-sso`` single-sign-on system, using your Divio Cloud credentials.
The default Saleor form is still available to use.

To set the ``aldryn-sso`` login form as the default, change ``LOGIN_URL`` in your settings to ``'aldryn_sso_login'``.
You can disable this functionality by removing ``aldryn-sso`` from ``INSTALLED_ADDONS`` in ``settings.py``. See
`Aldryn SSO <http://docs.divio.com/en/latest/reference/addons-aldryn-sso.html>`_ for more information.


Email
-----

You need to configure your project to be able to send email. You should set `EMAIL_URL` as your env variable; see
`Sending email in Divio Cloud applications <https://docs.divio.com/en/latest/reference/coding-sending-email.html>`_.

This uses the `dj-email-url package <https://github.com/migonzalvar/dj-email-url>`_.

When you are using external SMTP it should look like:
``submission://smtp_user:smtp_pass@smtp_host:port``


============
Contribution
============

You are very welcome improving this boilerplate for your everyday use. Feel free to fork and send us pull requests.

See `Saleor Official Documentation <https://docs.getsaleor.com/en/latest/>`_ for further information.


Updates
-------

Saleor requires all files to be added to your project, it is not a separate package compared to other Python
dependencies. To keep this repository up to date with recent Saleor releases, we created a simple update
script that does the heavy lifting for you::

    bash ./update_saleor.sh

Before applying, consult the `Saleor releases notes <https://github.com/mirumee/saleor/releases>`_ for changes
and update the changelog in this repository afterwards.

Please note that we do not override the ``settings.py`` file, you may need to do manual changes there.

Lastly, set the correct version in ``boilerplate.json`` and relase to Divio Cloud.
