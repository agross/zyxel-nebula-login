# zyxel-nebula-login

Zyxel Nebula in Basic mode (i.e. the free version) enables [Cloud-Saving
Mode](https://support.zyxel.eu/hc/en-us/articles/360020885720-Cloud-Saving-Mode-Nebula-BASE-Pack-)
once you stop using their web site for 30 days. This script can be run e.g.
every week to prevent turning on Cloud-Saving Mode. It does that by logging in
and pretending you are still active.

## How to use

1. Clone this repository
1. Install Ruby
1. `gem install bundler`
1. `bundle install`
1. `USER=you@example.com PASSWORD=your-nebula-passwort OTP_SECRET=123 bundle exec login.rb`

The script logs you in to Nebula using the values from the `USER` and `PASSWORD`
environment variables.

I have 2-factor authentication enabled, so I need to supply a one-time password
(OTP) in addition to username and password. I do not remember whether OTP is
required when registering a Nebula account. The script generates the OTP using a
Ruby library that needs the OTP secret. Pass the secret from the OTP URL that
you received when activating 2FA. E.g. if the OTP URL is
`otpauth://totp/you@example.com?digits=6&secret=ABCDEFEGHI` put `ABCDEFEGHI`
into the `OTP_SECRET` environment variable.
