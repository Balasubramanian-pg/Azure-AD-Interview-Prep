# Domain Local Groups

[WHY_IT_MATTERS]
This topic is fundamental to understanding the distinction between traditional on-premises Active Directory and Azure Active Directory. While "Domain Local Groups" are a core concept in Windows Server AD for resource access, they do not natively exist in Azure AD. Interviewers care about this topic to assess a candidate's foundational knowledge of identity management, their ability to differentiate between on-premises and cloud identity models, and their understanding of how hybrid environments handle group synchronization and access control. It often highlights whether a candidate truly understands Azure AD's native capabilities versus merely seeing it as an extension of on-prem AD.

[CORE_CONCEPTS]
**Domain Local Group (DLG)**: A group scope in on-premises Windows Server Active Directory. Its primary purpose is to grant access permissions to resources (files, folders, printers, shares) located within the *same domain* where the DLG resides. It can contain users, global groups, and universal groups from any domain in the forest. Its membership is replicated within its own domain.
**Azure Active Directory (Azure AD)**: Microsoft's cloud-based identity and access management service. It has its own group types (Security and Microsoft 365) which function differently from on-premises AD group scopes.
**Misconception**: A common misconception is that Domain Local Groups exist as a distinct group type in Azure AD with their on-premises scope semantics. They do not. When synchronized from on-premises AD to Azure AD via Azure AD Connect, they are represented as standard "Security" groups in Azure AD.

[HOW_IT_WORKS]
In an on-premises Active Directory environment, a Domain Local Group is created in the domain where a resource resides. Permissions to that resource are then assigned to the DLG. Users (or, more commonly, Global Groups containing users) from any trusted domain can be made members of this DLG. When a user authenticates against AD, their group memberships, including those to DLGs, are included in their security token, enabling authorization against the resource.
In Azure AD, the concept of a "domain local" scope doesn't apply. Azure AD groups are global in nature within the Azure AD tenant. When an on-premises DLG is synchronized to Azure AD by Azure AD Connect, it is converted into an Azure AD "Security" group. The group's members (users, other groups) are also synchronized. In Azure AD, this synchronized Security Group can then be used to grant access to cloud resources, SaaS applications, or Azure AD roles, just like any other cloud-native Azure AD Security Group. However, the original "domain local" scope meaning for resource ACLs only remains relevant for the on-premises resources it protects; it has no functional meaning within Azure AD itself for cloud resources.

[CONFIGURATION]
Domain Local Groups are configured and managed exclusively within on-premises Active Directory using tools like Active Directory Users and Computers (ADUC). They are not configured in Azure AD directly.
When synchronizing to Azure AD:
-   **Azure AD Connect**: This tool manages the synchronization of on-premises AD objects, including groups, to Azure AD. By default, security groups (which include Domain Local Groups) are synchronized. You configure synchronization rules within Azure AD Connect.
-   **Azure Portal**: You can view the synchronized Domain Local Groups (which appear as Azure AD Security Groups) under "Azure Active Directory" > "Groups". Their "Source" will indicate "Windows Server AD".
-   **PowerShell/Graph API**: You cannot create Domain Local Groups using Azure AD PowerShell (`New-AzureADGroup`) or Microsoft Graph API. These tools create native Azure AD Security or Microsoft 365 groups. You can manage membership of *synced* groups using these tools, but primarily from the Azure AD side.
-   **Conditional Access / Enterprise Apps**: Synced Domain Local Groups (as Azure AD Security Groups) can be used as conditions in Conditional Access policies or assigned to Enterprise Applications for access control, just like any other Azure AD group.

[USE_CASES]
**On-premises Use Cases:**
-   **Granular Resource Access Control:** Granting read/write access to a specific file share or folder within a domain (e.g., "DL_FinanceShare_Read" in the contoso.com domain).
-   **Application Permissions:** Assigning permissions within a line-of-business application that uses on-premises AD for authorization.
**When NOT to use this feature (in Azure AD context):**
-   You would never create a "Domain Local Group" directly in Azure AD, as the concept does not exist there.
-   When designing access control for cloud-native applications or Azure resources, you should use native Azure AD Security Groups, Azure RBAC, or application assignment directly. Relying on synced on-premises group structures might be overly complex if not carefully planned.

[INTERVIEW_QUESTIONS]
1.  Do Domain Local Groups exist natively in Azure AD? Explain your answer.
    *   *Hint*: No, they are an on-premises AD concept.
2.  How does an on-premises Domain Local Group appear in Azure AD after synchronization?
    *   *Hint*: As an Azure AD Security group.
3.  What is the primary purpose of a Domain Local Group in on-premises AD?
    *   *Hint*: Granting resource permissions within its own domain.
4.  Can you assign an Azure AD application access to a synchronized Domain Local Group?
    *   *Hint*: Yes, because it becomes an Azure AD Security group.
5.  Explain the AGDLP strategy and its relevance (or lack thereof) in a pure Azure AD environment.
    *   *Hint*: AGDLP is an on-prem best practice; less direct relevance in pure Azure AD, but important for hybrid.

[PITFALLS]
-   **Conceptual Misunderstanding**: Assuming that the "domain local" scope or behavior carries over to Azure AD.
-   **Over-Complication in Cloud**: Attempting to replicate complex on-premises AGDLP (Accounts in Global Groups, Global Groups in Domain Local Groups, Domain Local Groups get Permissions) structures for cloud-only resources, when simpler Azure AD group assignments would suffice.
-   **Security Implications**: Synced Domain Local Groups, if not properly reviewed, might inherit unintended permissions in Azure AD that were historically appropriate only for on-premises resources, creating a potential over-provisioning risk in the cloud.
-   **Troubleshooting Confusion**: Misinterpreting why a user has or lacks access to an Azure AD resource due to confusion about the origin and behavior of synced groups versus cloud-native groups.

[COMPARISON]
-   **Domain Local Groups (on-premises AD) vs. Azure AD Security Groups**: DLGs are resource-centric, domain-specific for permissions; AAD Security Groups are tenant-wide, used for managing access to cloud resources, applications, and Azure AD roles.
-   **Domain Local Groups vs. Global Groups (on-premises AD)**: DLGs define permissions on resources within their domain. Global Groups primarily organize users and other global groups from the *same* domain and are typically members of DLGs or Universal Groups.
-   **Domain Local Groups vs. Universal Groups (on-premises AD)**: DLGs are for resource permissions within a single domain. Universal Groups can contain users and groups from *any* domain in the forest and are typically used to group users for access to resources across multiple domains.
-   **Domain Local Groups vs. Microsoft 365 Groups (Azure AD)**: DLGs are purely security-focused groups for on-premises AD. Microsoft 365 Groups are collaborative groups with shared mailbox, calendar, files, and integration with M365 services, in addition to security capabilities.

[SUMMARY]
-   On-premises Active Directory group scope.
-   Used for assigning permissions to resources within a single AD domain.
-   Do NOT natively exist as a distinct type in Azure AD.
-   Synchronized to Azure AD as standard "Security" groups via Azure AD Connect.
-   Lose their "domain local" scope meaning within Azure AD itself.
-   Azure AD primarily uses Azure AD Security Groups for cloud resource access.

[REFERENCES]
-   Active Directory Domain Services Group Scopes: `https://docs.microsoft.com/windows-server/identity/ad-ds/manage/understand-group-scopes`
-   Compare groups on-premises and in Azure AD: `https://docs.microsoft.com/azure/active-directory/hybrid/concept-aadc-onprem-groups`
-   What are groups in Azure Active Directory?: `https://docs.microsoft.com/azure/active-directory/fundamentals/active-directory-groups-manage`
-   Azure AD Connect sync: Understanding groups: `https://docs.microsoft.com/azure/active-directory/hybrid/how-to-connect-sync-features#understanding-groups`

---
*Updated via Automation*