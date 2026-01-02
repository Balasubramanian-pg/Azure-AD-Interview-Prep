# SSO Troubleshooting Guide

## Common Issues

### AADSTS50011: Reply URL mismatch
**Solution**: Ensure Reply URL in Azure AD matches app's callback URL

### AADSTS700016: Application not found
**Solution**: Verify App ID URI or Client ID

### Invalid SAML Response
**Solution**: 
- Check clock sync between IdP and SP
- Validate certificates

### MFA Prompt Loop
**Solution**: 
- Exclude app from Conditional Access
- Adjust MFA settings
