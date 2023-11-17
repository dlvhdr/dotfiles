function mfa
  komo aws mfa -u dolev@komodor.io -t (op item get --otp "aws-login")
  set -Ux AWS_PROFILE mfa
end
