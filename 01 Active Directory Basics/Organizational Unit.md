# Organizational Unit

[WHY_IT_MATTERS]
This topic exists because Organizational Units (OUs) are a fundamental concept in Active Directory Domain Services (AD DS) that solve problems related to hierarchical organization and delegated administration within an on-premises environment. Understanding OUs is crucial for hybrid identity scenarios, as many organizations synchronize users, groups, and devices from AD DS to Azure AD. Interviewers care about this topic to gauge a candidate's foundational knowledge of AD DS, their understanding of the distinctions between on-premises and cloud identity constructs, and how these concepts relate or differ in a hybrid environment. It helps assess if a candidate understands that not all AD DS concepts have a direct, identical counterpart in Azure AD.

[CORE_CONCEPTS]
An Organizational Unit (OU) is a container object within an Active Directory Domain Services (AD DS) domain. Its primary purpose is to organize objects (users, groups, computers, other OUs) for administrative delegation and to apply Group Policy Objects (GPOs). OUs form a logical, hierarchical structure within a domain.
A common misconception is that OUs exist natively in Azure AD or that their structure is replicated to Azure AD during synchronization. This is incorrect. OUs are an AD DS-specific construct. While objects *within* OUs can be synchronized to Azure AD, the OU itself and its hierarchical structure are not recreated in Azure AD.

[HOW_IT_WORKS]
In AD DS, OUs allow administrators to create a granular hierarchy for managing resources. Permissions can be delegated at the OU level, granting specific users or groups administrative control over objects contained within that OU (e.g., reset passwords for users in the "Sales" OU). Group Policies are also linked to OUs, allowing specific security settings, software deployments, or desktop configurations to be applied to users and computers within those OUs. When objects from AD DS are synchronized to Azure AD using Azure AD Connect, the objects themselves (users, groups, devices) are created in Azure AD. However, the OU membership or hierarchy from AD DS is generally not carried over as a distinct attribute or structure within Azure AD. Azure AD operates primarily with a flat object model, where objects reside in a single tenant, and organization for delegation is achieved through Administrative Units and groups. Azure AD authentication is against the Azure AD tenant, independent of any original OU structure from AD DS.

[CONFIGURATION]
OUs are configured exclusively within an Active Directory Domain Services environment using tools like Active Directory Users and Computers (ADUC), PowerShell cmdlets (e.g., `New-ADOrganizationalUnit`), or other AD management tools. They are not configured directly in the Azure Portal, via Conditional Access, Enterprise Apps, or Microsoft Graph API, as they are not Azure AD objects. In a hybrid scenario, Azure AD Connect configuration allows for filtering synchronization based on specific OUs in AD DS. This is configured during the Azure AD Connect setup wizard or subsequently in the Synchronization Service Manager, enabling control over which AD DS objects based on their OU location are synchronized to Azure AD. For similar administrative delegation within Azure AD, Administrative Units (AUs) are configured in the Azure Portal, using Azure AD PowerShell, or Microsoft Graph.

[USE_CASES]
Real-world AD DS use cases for OUs include:
- Delegating administrative control of a specific department (ee.g., HR, Finance) to their local IT support staff without granting them domain-wide administrator privileges.
- Applying specific Group Policies to a subset of users or computers, such as mandatory desktop backgrounds for all users in a "Marketing" OU, or restrictive security settings for servers in a "DMZ" OU.
- Structuring the directory to reflect the organizational chart for easier management and policy application.
When NOT to use this feature: For organizing objects directly within an Azure AD tenant. Azure AD's native mechanisms like Administrative Units (for delegation) or dynamic/static groups (for policy/access) are the appropriate cloud-native alternatives. Attempting to replicate AD DS OU structures directly in Azure AD is a common misunderstanding.

[INTERVIEW_QUESTIONS]
- What is the primary purpose of an Organizational Unit in Active Directory?
- Do Organizational Units exist in Azure Active Directory? If not, what is the Azure AD equivalent for delegation?
- How does the concept of an OU relate to Azure AD Connect and hybrid identity?
- Can you apply Group Policy directly to objects in Azure AD based on their original AD DS OU? Why or why not?
- When would you choose to use an Administrative Unit in Azure AD versus an Organizational Unit in AD DS?

[PITFALLS]
- Assuming that the AD DS OU structure automatically or directly replicates into Azure AD.
- Over-complicating AD DS OU structures, leading to complex GPO inheritance and permission issues.
- Attempting to manage permissions or apply policies in Azure AD based on the original AD DS OU of a synchronized object.
- Not understanding that OU filtering in Azure AD Connect only controls *what* gets synchronized, not how the object is structured or managed *within* Azure AD post-sync.
- Confusing Administrative Units in Azure AD with OUs in AD DS, despite their similar high-level goal of delegation.

[COMPARISON]
- **Azure AD Administrative Units (AUs):** Both OUs (AD DS) and AUs (Azure AD) serve to scope administrative permissions. However, AUs are a flat list of objects for delegation within Azure AD, whereas OUs are hierarchical containers within an AD DS domain for delegation and GPO application. AUs do not support GPOs.
- **Azure AD Groups:** Both OUs and groups can be used to organize objects and apply permissions or policies. OUs are containers that objects reside in. Groups are collections of objects. In Azure AD, groups are heavily used for access control, application assignment, and conditional access policies, providing much of the policy application functionality that GPOs linked to OUs provide in AD DS.
- **AD DS Domains:** OUs are strictly contained within a single AD DS domain and cannot span multiple domains.

[SUMMARY]
- OUs are an Active Directory Domain Services (AD DS) concept for hierarchical organization.
- Primary uses: administrative delegation and Group Policy Object (GPO) application within AD DS.
- OUs do NOT exist natively in Azure AD; their structure is not synchronized.
- Azure AD Connect can filter synchronized objects based on their AD DS OU.
- Azure AD uses Administrative Units (AUs) for cloud-native administrative delegation.
- Azure AD relies on groups for policy application and access control.
- Critical for understanding hybrid identity distinctions and cloud-native approaches.

[REFERENCES]
- Microsoft Learn: "What are administrative units in Azure Active Directory?" (https://learn.microsoft.com/en-us/azure/active-directory/roles/administrative-units)
- Microsoft Learn: "Filter using organizational units (OUs) in Azure AD Connect" (https://learn.microsoft.com/en-us/azure/active-directory/hybrid/how-to-connect-install-custom#filter-using-organizational-units)
- Microsoft Learn: "Active Directory Domain Services Overview" (for foundational AD DS concepts including OUs) (https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/active-directory-domain-services)

---
*Updated via Automation*