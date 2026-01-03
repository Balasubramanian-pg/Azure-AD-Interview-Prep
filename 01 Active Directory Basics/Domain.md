# Domain

[WHY_IT_MATTERS]
This topic exists because organizations need to use their own branded domain names (e.g., contoso.com) for user identities and services within Azure AD, rather than the default .onmicrosoft.com domain. It solves the problem of generic branding and provides a familiar sign-in experience for users. Interviewers care because understanding domains is fundamental to configuring identity, authentication, hybrid environments, and ensuring a professional, consistent user experience across cloud services. It's a foundational concept for managing identity within Azure AD.

[CORE_CONCEPTS]
**Domain (DNS Domain Name):** A unique, hierarchical name within the Domain Name System used to identify an internet resource.
**Azure AD Tenant Primary Domain:** The default domain automatically created with every Azure AD tenant, always in the format `.onmicrosoft.com`.
**Custom Domain:** A domain name owned by an organization (e.g., `contoso.com`) that is registered and verified for use within their Azure AD tenant.
**Managed Domain:** A custom domain where Azure AD directly performs user authentication.
**Federated Domain:** A custom domain where user authentication is delegated to an external identity provider (IdP), such as on-premises Active Directory Federation Services (AD FS), often for single sign-on or legacy application compatibility.
**Domain Verification:** The process of proving ownership of a custom domain by adding specific DNS records (e.g., TXT or MX) to the public DNS zone for that domain.
**User Principal Name (UPN) Suffix:** The domain part of a user's UPN (e.g., `user@contoso.com`), which must correspond to a verified domain in Azure AD.
*Common Misconception:* An Azure AD domain is not the same as an Active Directory Domain Services (AD DS) domain. While related in hybrid scenarios, an Azure AD domain is primarily a namespace for cloud identities and services, not a traditional domain controller structure.

[HOW_IT_WORKS]
When an organization wants to use `contoso.com` for their users in Azure AD, they first add it as a custom domain. Azure AD then requires domain verification, typically by instructing the organization to add a specific TXT or MX record to their public DNS settings for `contoso.com`. Once the DNS record is propagated and detected by Azure AD, the domain's ownership is confirmed, and it becomes "Verified."
Users can then have UPNs using this custom domain (e.g., `user@contoso.com`). When a user attempts to sign in, Azure AD inspects the domain portion of the UPN.
If the domain is configured as **Managed**, Azure AD handles the authentication directly using cloud-based credentials.
If the domain is configured as **Federated**, Azure AD redirects the authentication request to the external identity provider (e.g., ADFS) associated with that domain. The external IdP then authenticates the user and issues a token back to Azure AD.
The domain determines the authentication method and often the tenant context for the sign-in flow.

[CONFIGURATION]
Domain management is primarily configured in the **Azure Portal** under `Azure Active Directory` -> `Custom domain names`.
**Adding a custom domain:**
1. Navigate to "Custom domain names."
2. Click "+ Add custom domain."
3. Enter the desired domain name (e.g., `contoso.com`).
4. Azure AD provides specific DNS records (TXT or MX) that must be added to the public DNS zone for that domain.
5. Once the DNS records are added, click "Verify" in the portal.
**Setting Primary Domain:** After verification, any custom domain can be set as the "primary" domain, which becomes the default suffix for new user accounts created directly in Azure AD.
**Domain Type (Managed/Federated):** This status is often configured during hybrid setup (e.g., Azure AD Connect federation settings) or by using PowerShell/Graph API.
**PowerShell/Graph API:** Custom domains can be managed using `New-MsolDomain`, `Set-MsolDomain`, `Remove-MsolDomain` cmdlets or the Microsoft Graph API endpoints `/domains`.

[USE_CASES]
*   **Branding and User Experience:** Allows users to sign in with their familiar corporate email domain (e.g., `user@contoso.com`) instead of the default `.onmicrosoft.com` domain, improving trust and brand recognition.
*   **Hybrid Identity:** Essential for synchronizing users from on-premises Active Directory whose UPN suffixes match custom domains in Azure AD, ensuring a consistent identity across cloud and on-premises resources.
*   **Identity Unification:** Consolidating multiple distinct domains or company acquisitions into a single Azure AD tenant while maintaining separate UPNs for different user groups.
*   **Federated Single Sign-On (SSO):** Enabling SSO for users whose authentication is handled by an external IdP (like ADFS or Okta) for specific domains, allowing existing identity infrastructure to be leveraged.
*   **Email and Service Integration:** Ensures services like Exchange Online can correctly route email and other communications based on the organization's primary domain.
*   *When NOT to use this feature:* Domains are a foundational concept in Azure AD; you always have at least one (`.onmicrosoft.com`) and will almost always add custom domains for practical use. There isn't a scenario where you would *choose* not to use domains at all.

[INTERVIEW_QUESTIONS]
*   What is the primary reason an organization adds a custom domain to Azure AD? (Hint: Branding, user experience, hybrid identity.)
*   Explain the difference between a "managed" and a "federated" domain in Azure AD. (Hint: Authentication source – AAD vs. external IdP.)
*   How do you prove ownership of a custom domain to Azure AD? (Hint: DNS verification via TXT or MX records.)
*   Can a single Azure AD tenant have multiple custom domains? If so, what are some use cases? (Hint: Yes, acquisitions, business units, different branding.)
*   What is the relationship between a user's UPN and the domains configured in Azure AD? (Hint: UPN suffix must be a verified domain.)

[PITFALLS]
*   **DNS Misconfiguration:** Incorrect or unpropagated DNS records for verification can prevent domain setup, cause service interruptions, or lead to mail flow issues.
*   **UPN Suffix Mismatches:** If a user's UPN suffix in on-premises AD does not correspond to a verified custom domain in Azure AD, it can cause synchronization errors or prevent users from signing in with their expected UPN.
*   **Confusing Primary Domain:** Thinking the primary domain for sign-in is the same as the primary email domain, which can sometimes be separate concerns.
*   **Accidental Domain Removal:** Deleting a domain that is still in use by user accounts or services can lead to service outages and authentication failures.
*   **Federation Complexity:** Mismanaging the federation settings for a domain can break SSO, leading to users being unable to authenticate.
*   **Licensing Implications:** While not a direct domain pitfall, domain choices often influence how licenses are assigned and managed for users associated with specific domains.

[COMPARISON]
*   **Azure AD Domain vs. On-premises Active Directory Domain Services (AD DS) Domain:** An Azure AD domain is a naming space and authentication boundary for cloud identities within a tenant. An AD DS domain is a logical security boundary in an on-premises network, providing a database of users, computers, and resources, managed by domain controllers using Kerberos/LDAP. They are distinct but can be linked in hybrid scenarios.
*   **Azure AD Tenant vs. Domain:** An Azure AD tenant is the dedicated instance of Azure AD for an organization, acting as a container for all identities, applications, and resources. A domain is a naming space *within* that tenant. One tenant can host multiple domains, but each domain belongs to only one tenant at a time.
*   **Managed Domain (in AAD) vs. Azure AD Domain Services (AAD DS):** A "managed domain" in the context of Azure AD simply refers to an authentication method where Azure AD directly manages credentials. Azure AD Domain Services (AAD DS), however, is a separate Azure service that provides managed domain controllers, offering Kerberos/LDAP authentication for legacy applications that require traditional domain join capabilities in Azure VMs, often complementing a managed Azure AD domain.

[SUMMARY]
*   Domains are fundamental namespaces for identities within an Azure AD tenant.
*   Every tenant starts with a `.onmicrosoft.com` primary domain.
*   Custom domains allow organizations to use their own branding (e.g., `contoso.com`).
*   Ownership of custom domains is verified via public DNS records.
*   Domains can be "managed" (Azure AD authenticates) or "federated" (external IdP authenticates).
*   User Principal Names (UPNs) use verified domain suffixes.
*   Crucial for branding, hybrid identity, and consistent user sign-in experiences.

[REFERENCES]
*   Microsoft Learn: Add your custom domain name to Azure Active Directory - [https://learn.microsoft.com/en-us/azure/active-directory/fundamentals/add-custom-domain](https://learn.microsoft.com/en-us/azure/active-directory/fundamentals/add-custom-domain)
*   Microsoft Learn: What is domain verification? - [https://learn.microsoft.com/en-us/azure/active-directory/fundamentals/add-custom-domain-verify](https://learn.microsoft.com/en-us/azure/active-directory/fundamentals/add-custom-domain-verify)
*   Microsoft Docs: UserPrincipalName population in Azure AD - [https://learn.microsoft.com/en-us/azure/active-directory/hybrid/plan-connect-userprincipalname](https://learn.microsoft.com/en-us/azure/active-directory/hybrid/plan-connect-userprincipalname)

---
*Updated via Automation*