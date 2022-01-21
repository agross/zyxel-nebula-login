#!/usr/bin/env ruby
# frozen_string_literal: true

require 'mechanize'
require 'rotp'

ROOT_URL = 'https://accounts.myzyxel.com/oauth2/authorize?response_type=token&client_id=d133165ec6634b380bdab3dac436159ed15c0f2de8b1148867e1c1670a7a04d8&redirect_uri=https%3A%2F%2Fnebula.zyxel.com%2Fcc%2Findex.html'
USER = ENV['USER'] || raise('Need user')
PASSWORD = ENV['PASSWORD'] || raise('Need password')
OTP_SECRET = ENV['OTP_SECRET'] || raise('Need OTP secret')

totp = ROTP::TOTP.new(OTP_SECRET)

Mechanize.new do |agent|
  login = agent.get(ROOT_URL)

  form = login.form_with(method: 'POST')
  form.field_with(type: 'email').value = USER
  form.field_with(type: 'password').value = PASSWORD

  form.submit

  form = agent.page.form_with(method: 'POST')
  form.field_with(type: 'text').value = totp.now

  form.submit

  uri = agent.page.uri.to_s
  raise "Login appears to have failed, ended up at #{uri}" \
    unless uri.start_with?('https://nebula.zyxel.com/cc/index.html')

  puts 'Logged in'
end
