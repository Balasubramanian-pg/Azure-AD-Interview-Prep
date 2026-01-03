# Group Policy Gpo

[WHY_IT_MATTERS]
This topic exists because Group Policy Objects (GPOs) are a foundational element of traditional Active Directory Domain Services (AD DS) for managing Windows environments. While GPOs are not native to Azure Active Directory (Azure AD), interviewers care because understanding the shift from GPO-based management to modern cloud-based management (like Microsoft Intune) is critical for hybrid and cloud-first organizations. It demonstrates a candidate's grasp of legacy infrastructure, migration challenges, and the evolution of device and user management in the Microsoft ecosystem.

[CORE_CONCEPTS]
**Group Policy Object (GPO):** A collection of settings that define the working environment for user accounts and computer accounts within an Active Directory domain. GPOs are stored in AD DS and Sysvol, and they are processed by domain-joined Windows clients.
**Local GPO:** A policy stored directly on a local computer, applied only to that specific machine and its users.
**MDM Policy (e.g., Intune):** A modern management policy deployed from a Mobile Device Management (MDM) solution like Microsoft Intune, which is tightly integrated with Azure AD. These policies configure settings on devices (Windows, iOS, Android, macOS) regardless of their domain join status, often using OMA-URI (Open Mobile Alliance Uniform Resource Identifier) or Configuration Service Providers (CSPs).
**Common Misconception:** That GPOs can directly manage Azure AD-joined or Azure AD registered devices without a hybrid setup. GPOs apply only to devices that are joined to an on-premises Active Directory domain and can communicate with a Domain Controller. Pure Azure AD-joined devices do not process GPOs.

[HOW_IT_WORKS]
In traditional AD DS, GPOs are linked to Sites, Domains, or Organizational Units (OUs). When a domain-joined computer starts or a user logs in, it contacts a Domain Controller to retrieve and apply the relevant GPOs based on the processing order (Local, Site, Domain, OU – LSDOU). GPOs define settings like password policies, security restrictions, software deployment, and registry modifications. For Azure AD, the control flow for device configuration shifts to MDM solutions like Intune. Azure AD-joined devices enroll with Intune (or another MDM), and Intune pushes configuration profiles and policies directly to the device over the internet. These policies are based on device and user identities in Azure AD, using device authentication (for enrollment) and user authorization (for policy assignment). There is no direct GPO processing against Azure AD objects; rather, MDM policies provide similar configuration capabilities in a cloud-native fashion.

[CONFIGURATION]
GPOs themselves are configured using the Group Policy Management Console (GPMC) on a domain-joined server within an AD DS environment. They are *not* configured directly in the Azure portal for Azure AD.
For managing Azure AD-joined or hybrid Azure AD-joined devices with equivalent functionality:
*   **Microsoft Intune (part of Microsoft Endpoint Manager):** Configured via the Microsoft Endpoint Manager admin center (endpoint.microsoft.com). This is the primary Azure AD-integrated platform for modern device management. You create configuration profiles, compliance policies, app protection policies, etc., and assign them to Azure AD users or device groups.
*   **Security Defaults:** A baseline set of security policies enabled directly in Azure AD (via Azure portal > Azure Active Directory > Properties > Manage Security Defaults) providing MFA, risky sign-in protection, and blocking legacy authentication.
*   **Conditional Access Policies:** Configured in the Azure portal (Azure Active Directory > Security > Conditional Access) to enforce conditions (e.g., MFA, compliant device, trusted location) for accessing Azure AD applications.
*   **PowerShell/Graph API:** Intune policies, Conditional Access policies, and other Azure AD settings can also be configured programmatically using Microsoft Graph API or PowerShell with the Microsoft Graph SDK.

[USE_CASES]
**When GPOs are used:**
*   Managing legacy, on-premises, domain-joined Windows servers and workstations in traditional AD DS environments.
*   In hybrid Azure AD environments, for devices that are *both* domain-joined and Azure AD-registered/joined, GPOs still manage traditional domain settings, while Intune manages cloud-specific settings.
*   Applying deep-level Windows OS customizations or specific legacy application configurations that might not yet have an MDM equivalent (though Intune is rapidly expanding its CSP support).
**When NOT to use GPOs (or rely solely on them):**
*   For cloud-first organizations or devices that are solely Azure AD-joined or Azure AD registered.
*   Managing mobile devices (iOS, Android, macOS) or non-Windows endpoints.
*   When a simpler, more modern, internet-centric management solution like Intune is available, offering flexibility and reduced infrastructure overhead.
*   When migrating to a fully cloud-managed environment.

[INTERVIEW_QUESTIONS]
*   Explain the fundamental difference between GPOs and Intune policies.
*   How would you manage settings on an Azure AD-joined Windows 10 device that historically would have been applied via GPO?
*   Describe a scenario where both GPOs and Intune policies might be in effect on the same device.
*   What are the limitations of GPOs in a pure Azure AD environment?
*   How do you ensure consistent security baselines across devices when transitioning from GPOs to modern management?
*   If a client asked you to move from a GPO-centric management model to a cloud-native one, what would be your initial steps and considerations?

[PITFALLS]
*   **Assuming GPOs apply to Azure AD-joined devices:** This is a common misunderstanding. Pure Azure AD-joined devices do not process GPOs.
*   **Overlooking Intune's capabilities:** Not realizing that Intune can replicate most, if not all, common GPO settings through configuration profiles and administrative templates.
*   **Complexity in hybrid environments:** Managing overlapping policies from both GPOs and Intune can lead to conflicts and troubleshooting challenges if not planned carefully. MDM policy generally wins for settings where both are configured on hybrid-joined devices.
*   **Ignoring Security Baselines:** Failing to implement modern security baselines (e.g., via Intune Security Baselines) when moving away from GPO-enforced security.
*   **Lack of Reporting Parity:** GPO reporting (RSOP, GPRESULT) differs significantly from Intune's reporting capabilities, requiring a shift in how compliance and applied settings are monitored.

[COMPARISON]
*   **GPO vs. Microsoft Intune Policies:** GPOs are for on-premises AD DS, require line-of-sight to a DC, are pull-based, and primarily for Windows. Intune policies are cloud-based (Azure AD integration), work over the internet, are push-based (via MDM agent), and support multiple OS platforms. Intune offers similar configuration capabilities for Windows devices (e.g., through Administrative Templates, Device Restriction profiles, Custom OMA-URI).
*   **GPO vs. Conditional Access:** GPOs define device and user configurations. Conditional Access defines *access rules* to resources based on user, device, application, location, and risk. While both enforce policies, GPOs manage the *state* of the device/user, whereas Conditional Access manages *who/what/how* can access resources *after* authentication.
*   **GPO vs. Azure AD Security Defaults:** Security Defaults are a simple, foundational set of security policies for all tenants without requiring specific configuration or licensing beyond Azure AD Free. GPOs are highly granular and require a domain. Security Defaults can be seen as a very basic, always-on cloud equivalent to some core GPO security settings, primarily around MFA and blocking legacy authentication.

[SUMMARY]
*   GPOs are fundamental to traditional AD DS, not native to Azure AD.
*   They manage domain-joined Windows devices, requiring DC connectivity.
*   Modern Azure AD environments use Intune (MDM) for device and user configuration.
*   Intune policies are cloud-based, internet-accessible, and cross-platform.
*   Hybrid environments may use both GPOs and Intune, with MDM winning in conflicts.
*   Conditional Access provides access control, not direct device configuration.
*   Interviewers gauge understanding of legacy management, hybrid transitions, and modern cloud alternatives.

[REFERENCES]
*   What is Group Policy? - Microsoft Learn: `https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/manage/understand-group-policy`
*   What is Microsoft Intune? - Microsoft Learn: `https://learn.microsoft.com/en-us/mem/intune/fundamentals/what-is-intune`
*   Use Group Policy to manage Windows 10/11 devices joined to Azure AD Hybrid Join - Microsoft Learn: `https://learn.microsoft.com/en-us/windows/client-management/mdm/group-policy-vs-mdm`
*   Configure Group Policy settings on Windows 10/11 devices in Microsoft Intune - Microsoft Learn: `https://learn.microsoft.com/en-us/mem/intune/configuration/administrative-templates-windows`
*   What are Conditional Access policies? - Microsoft Learn: `https://learn.microsoft.com/en-us/azure/active-directory/conditional-access/overview`

---
*Updated via Automation*