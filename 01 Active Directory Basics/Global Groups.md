# Global Groups

[WHY_IT_MATTERS]
This topic is fundamental to scalable and secure identity management. Managing permissions for individual users is highly inefficient, prone to error, and difficult to audit, especially in large enterprises. Groups solve this by allowing administrators to assign permissions once to a group, then simply add or remove users from that group. This implements the principle of least privilege more effectively and streamlines administration. Interviewers care because it demonstrates a candidate's understanding of core access control mechanisms, security best practices, operational efficiency, and the ability to design robust authorization models in Azure AD.

[CORE_CONCEPTS]
In Windows Server Active Directory, a "Global Group" is a group scope designed to contain user accounts, computer accounts, and other global groups from its own domain. It can be used to grant access to resources in any domain within the same forest. In Azure Active Directory, the concept of a "Global Group" as a distinct scope type does not exist. Instead, Azure AD *Security Groups* inherently serve a similar purpose by being tenant-wide in their scope. When referring to "Global Groups" in an Azure AD context, it typically implies using an Azure AD Security Group to manage access to resources, applications, or roles *globally* within a single Azure AD tenant. These groups can contain users, other security groups, and service principals from the same tenant. A common misconception is assuming Azure AD groups have the same scope distinctions (Domain Local, Global, Universal) as on-premises AD; Azure AD groups are, by design, effectively tenant-universal for authorization purposes.

[HOW_IT_WORKS]
Azure AD Security Groups (which fulfill the "global group" concept in Azure AD) are directory objects. When a user or service principal is added as a member to such a group, that membership is recorded in Azure AD. For authorization, when a user authenticates to Azure AD to access an Azure AD-protected resource (e.g., a SaaS application, an Azure resource, a custom line-of-business application), Azure AD issues a security token. This token, typically a JSON Web Token (JWT), includes claims about the user, and critically, their group memberships (represented by the group's object ID). The control flow is: an administrator adds users/service principals to an Azure AD Security Group; the administrator assigns this group to an application role, an Azure RBAC role, or grants it access to a resource; when the user attempts to access the resource, their token is presented; the resource or the underlying authorization system checks if the group object ID present in the user's token is among those granted access; access is then granted or denied based on this evaluation.

[CONFIGURATION]
Azure AD Security Groups are configured primarily through the Azure Portal. Navigate to Azure Active Directory -> Groups -> New group, then select "Security" as the Group type. They can also be created and managed using Azure AD PowerShell cmdlets, such as `New-AzureADGroup -DisplayName "MyGlobalSecurityGroup" -MailEnabled $false -SecurityEnabled $true`. For programmatic creation and management, the Microsoft Graph API is used via the `/groups` endpoint with `groupTypes=["Security"]`. Once created, these groups can be assigned to enterprise applications (for app role assignments), Azure RBAC roles, PIM eligible roles, and targeted by Conditional Access policies. Members can be added manually, dynamically via rules (for dynamic groups), or synchronized from on-premises AD via Azure AD Connect.

[USE_CASES]
- **SaaS Application Access**: Granting a consistent set of users access to applications like Salesforce, Workday, or ServiceNow.
- **Azure RBAC Role Assignment**: Assigning Azure built-in roles (e.g., Reader, Contributor) to a group for managing Azure resources.
- **Custom Application Authorization**: Defining access to custom line-of-business applications developed in-house.
- **Microsoft 365 Group-based Licensing**: Assigning product licenses (e.g., Microsoft 365 E5) to users based on their group membership.
- **Privileged Identity Management (PIM)**: Making groups eligible for PIM roles to manage elevated access.
- **Conditional Access Policy Targeting**: Scoping Conditional Access policies to specific groups of users.
When NOT to use this feature: For highly specific, individual user permissions that do not align with any group function; for managing on-premises domain-specific resources without synchronizing these groups via Azure AD Connect; or for general collaboration features where a Microsoft 365 Group with its associated resources (mailbox, SharePoint site, Teams) would be more appropriate.

[INTERVIEW_QUESTIONS]
- Explain the concept of "Global Groups" in Azure AD, contrasting it with on-premises AD.
- How do you leverage Azure AD Security Groups to manage access to an enterprise application?
- What are the primary benefits of using groups over individual assignments for access management in Azure?
- Can an Azure AD security group contain members from another Azure AD tenant? Why or why not?
- Describe a scenario where you would use a security group versus a Microsoft 365 group.
- How do security groups integrate with Azure RBAC?

[PITFALLS]
- **Over-provisioning**: Granting groups excessive permissions beyond what is necessary, violating the principle of least privilege.
- **Group Sprawl**: Creating too many redundant or overlapping groups, leading to management complexity and confusion.
- **Lack of Ownership/Review**: Groups without clear owners or regular access reviews can accumulate unnecessary members or permissions over time, posing security risks.
- **Nested Group Complexity**: While supported (especially when synchronized from on-premises AD), deeply nested groups can complicate troubleshooting and impact token size, potentially leading to authorization issues or performance degradation.
- **Orphaned Groups**: Groups that are no longer used but still exist, potentially retaining old permissions that could be exploited.
- **Misunderstanding Scopes**: Incorrectly applying on-premises AD group scope concepts (Domain Local, Global, Universal) to Azure AD groups, which are inherently tenant-wide for security purposes.

[COMPARISON]
- **Microsoft 365 Groups**: While also security-enabled, they are primarily designed for collaboration and come with a suite of shared resources (e.g., shared mailbox, calendar, SharePoint site, Teams). Azure AD Security Groups (the Azure AD equivalent of "Global Groups") are purely for security and access management, without the associated collaboration resources.
- **Dynamic Groups**: These are a type of Azure AD Security Group where membership is automatically determined by rules based on user or device attributes, whereas traditional Azure AD Security Groups typically have manually managed or synchronized static membership.
- **Azure AD Roles**: These are built-in roles (e.g., Global Administrator, User Administrator) that grant permissions to manage Azure AD itself. Security groups can be *assigned* to these roles (with PIM for eligible assignments), but the groups themselves are not roles.
- **On-premises AD Global Groups**: These are scoped to a single domain and primarily used for organizing users within that domain. Azure AD Security Groups are tenant-global, managing access across all resources within a single Azure AD tenant.

[SUMMARY]
- Azure AD Security Groups are the functional equivalent of "Global Groups" in Azure AD.
- They are tenant-wide and used for centralized access management.
- Grant access to applications, resources, and roles within the tenant.
- Configured via Azure Portal, PowerShell, or Microsoft Graph.
- Essential for implementing least privilege and scaling administration.
- Key considerations: avoid over-provisioning, manage sprawl, conduct regular access reviews.

[REFERENCES]
- What are security groups in Azure Active Directory?: `https://learn.microsoft.com/en-us/azure/active-directory/fundamentals/concept-learn-about-groups`
- Create a basic group and add members using Azure Active Directory: `https://learn.microsoft.com/en-us/azure/active-directory/fundamentals/active-directory-groups-create-azure-portal`
- New-AzureADGroup (Azure AD PowerShell documentation): `https://learn.microsoft.com/en-us/powershell/module/azuread/new-azureadgroup`
- Microsoft Graph API: Create group: `https://learn.microsoft.com/en-us/graph/api/group-post-groups`

---
*Updated via Automation*