# Group Types

[WHY_IT_MATTERS]
This topic exists to solve the fundamental problem of managing access and permissions efficiently at scale. Instead of individually assigning access to every user, groups allow administrators to define permissions once for a collection of users, significantly reducing administrative overhead and ensuring consistency. Interviewers care because it demonstrates an understanding of core identity management principles, security best practices, and how to design scalable and maintainable access control solutions in Azure AD.

[CORE_CONCEPTS]
**Security groups**: Used to manage user and computer access to shared resources. They can be assigned permissions to Azure resources (via RBAC), Enterprise applications, or Azure AD roles. Can be mail-enabled (Mail-enabled security groups).
**Microsoft 365 groups (Unified groups)**: Designed for collaboration, providing a shared workspace including a shared mailbox, calendar, SharePoint site, OneNote notebook, Planner, and optionally a Teams team. They also provide access to these associated M365 resources and can be used for access control to other M365 services. Always mail-enabled.
**Distribution groups**: Used solely for sending emails to a list of users. They cannot be used to assign permissions or access to resources.
**Mail-enabled security groups**: A type of security group that can also receive email. They combine the access control capabilities of a security group with the ability to function as an email distribution list.
**Common Misconception**: Microsoft 365 groups are often misunderstood as being *only* for collaboration. While their primary design is for collaboration, they *do* provide access control capabilities for their associated M365 resources and can be used for certain application assignments, making them a hybrid solution. Another misconception is that Distribution groups can grant access; they cannot.

[HOW_IT_WORKS]
When a user attempts to access a resource protected by Azure AD, they first authenticate. Azure AD then issues a security token (e.g., JWT). This token contains claims about the user, including their group memberships (represented by Object IDs or SIDs). The target application or resource (e.g., an Azure resource via RBAC, a SaaS app, or an M365 service) then evaluates these group claims against its defined authorization policies. If the user's token includes membership in a group that has been granted access, authorization is approved. For Microsoft 365 groups, their creation automatically provisions and links multiple M365 services (e.g., SharePoint site, Teams team) and membership is synchronized across these linked resources, simplifying access management for collaboration.

[CONFIGURATION]
Group types are selected during group creation.
- **Azure Portal**: Navigate to Azure Active Directory -> Groups -> All groups -> New group. Here, you choose "Security" or "Microsoft 365" as the Group type. You can also make a Security group "Mail-enabled" if desired.
- **PowerShell**: `New-AzureADGroup` or `New-MgGroup` (using Microsoft Graph PowerShell SDK). Parameters like `-GroupType` (e.g., "Security", "Unified"), `-MailEnabled:$true`, and `-SecurityEnabled:$true` are used. For example, `New-MgGroup -DisplayName "MyM365Group" -GroupTypes "Unified" -MailEnabled -SecurityEnabled -MailNickname "MyM365Group"` creates an M365 group.
- **Microsoft Graph API**: Use `POST /groups` endpoint. The `groupTypes` property is an array; `["Security"]` for a security group, or `["Unified"]` for an M365 group. Other properties like `mailEnabled` and `securityEnabled` are also set.
- **Conditional Access**: Groups are widely used as assignments for "Users and groups" in Conditional Access policies to scope policies to specific user populations (included or excluded).
- **Enterprise Applications**: Groups are the preferred method for assigning users to applications registered in Azure AD, enabling scalable access provisioning.

[USE_CASES]
**Security Groups**:
- Granting users access to Azure resources (e.g., Virtual Machines, Storage Accounts) via Azure RBAC role assignments.
- Assigning users to SaaS applications integrated with Azure AD.
- Controlling access to administrative roles within Azure AD (e.g., assigning users to the "Global Reader" role).
- Defining the scope for Conditional Access policies.
- Managing access to on-premises resources when synced from Active Directory Domain Services.
**Microsoft 365 Groups**:
- Creating collaborative workspaces in Microsoft Teams, SharePoint Online, and Outlook for project teams or departments.
- Providing a shared inbox and calendar for a team.
- Enabling self-service group creation and management for end-users, subject to governance policies.
- Granting access to the specific resources (e.g., SharePoint site, Teams channel) associated with the M365 group.
**When NOT to use this feature**:
- Using Distribution groups for access control; they lack security principals.
- Creating an M365 group solely for security access without any need for the integrated collaboration tools; a Security group would be simpler and more appropriate.
- Assigning permissions directly to individual users when a group can logically represent the required access, leading to management overhead.

[INTERVIEW_QUESTIONS]
- Differentiate between Azure AD Security groups and Microsoft 365 groups.
    - *Hint*: Security is primarily for access to resources; M365 is for collaboration with integrated services, but also provides access to its own resources.
- When would you choose a Mail-enabled security group over a standard Security group?
    - *Hint*: When the group needs to both grant access *and* receive emails.
- How do group types impact access control in Azure RBAC?
    - *Hint*: Only Security groups (and Mail-enabled Security groups) can be directly assigned Azure roles. M365 groups cannot be assigned Azure RBAC roles.
- Can you assign an Azure AD administrative role to a Microsoft 365 group?
    - *Hint*: No, only Security groups can be assigned Azure AD administrative roles.
- Describe a scenario where using groups is critical for a Conditional Access policy.
    - *Hint*: Scoping a "Require MFA" policy only to privileged users.

[PITFALLS]
- **Group Sprawl**: Creating too many groups, leading to management complexity and confusion.
- **Incorrect Group Type Selection**: Forgetting that Distribution groups cannot provide access, or using M365 groups for purely security-focused scenarios without collaboration needs.
- **Lack of Governance**: No clear owners for groups, leading to stale memberships, unmanaged access, and security risks.
- **Complex Nesting**: Overly complex nested group structures can make troubleshooting access issues difficult.
- **Orphaned Groups**: Groups remaining after projects or departments disband, accumulating unnecessary permissions.
- **Uncontrolled M365 Group Creation**: Users creating numerous M365 groups without policies, leading to sprawl and clutter.
- **Hybrid Identity Challenges**: Misunderstanding how on-premises AD group types (e.g., universal, global, domain local) map and function when synchronized to Azure AD.

[COMPARISON]
- **Security Groups vs. Microsoft 365 Groups**: Security groups are fundamental for access control to almost any resource (Azure RBAC, applications, M365 content). M365 groups are optimized for collaboration, offering a suite of integrated services (Teams, SharePoint, Outlook, Planner) alongside access to those specific resources. M365 groups are not assignable to Azure RBAC roles, unlike Security groups.
- **Distribution Groups vs. Mail-enabled Security Groups**: Distribution groups are solely for email distribution and provide no access control capabilities. Mail-enabled Security groups offer both email distribution and access control capabilities, making them dual-purpose.
- **Azure AD Groups vs. On-premises AD Groups**: Azure AD groups are cloud-native. On-premises AD groups (Universal, Global, Domain Local) can be synchronized to Azure AD via Azure AD Connect. When synced, they typically become "Security" or "Distribution" groups in Azure AD and can then be used for cloud resource access.

[SUMMARY]
- Azure AD offers three main group types: Security, Microsoft 365 (Unified), and Distribution.
- **Security groups** are for access control to most Azure AD integrated resources and Azure RBAC.
- **Microsoft 365 groups** are for collaboration, integrating shared services, and providing access to their associated resources.
- **Distribution groups** are email-only and cannot grant access.
- Proper group type selection is crucial for effective access management, security, and collaboration.
- Groups enable scalable and efficient identity management by assigning permissions once to a collection of users.
- Manageable via Azure Portal, PowerShell, and Microsoft Graph API.

[REFERENCES]
- What are groups in Azure Active Directory?: https://learn.microsoft.com/en-us/azure/active-directory/fundamentals/concept-learn-about-groups
- Compare groups: https://learn.microsoft.com/en-us/microsoft-365/admin/create-groups/compare-groups?view=o365-worldwide
- Microsoft 365 groups and Azure Active Directory: https://learn.microsoft.com/en-us/azure/active-directory/enterprise-users/groups-overview-m365

---
*Updated via Automation*