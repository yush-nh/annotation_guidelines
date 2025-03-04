# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## ReCAPTCHA settings procedure
Note: The reCAPTCHA feature will be off if site_key and secret_key are not set.

Access the Google reCAPTCHA site and log in with your Google account.
```
https://www.google.com/recaptcha/admin/create
```

Enter the required information.

label example:
```
near-note
```

reCAPTCHA type:
```
v2 "I'm not a robot" checkbox
```

domain:  
Add your domain, example:
```
example.com
```

After you register your site, site_key and secret_key are generated.  
Add keys to .env file to use reCAPTCHA on your app.
```
RECAPTCHA_SITE_KEY=[Generated site key]
RECAPTCHA_SECRET_KEY=[Generated secret key]
```
