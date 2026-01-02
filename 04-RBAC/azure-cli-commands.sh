#!/bin/bash
# Azure RBAC CLI Commands

# Assign 'Contributor' role to a user for a resource group
az role assignment create   --assignee "jdoe@contoso.com"   --role "Contributor"   --resource-group "Sales-RG"

# List role assignments
az role assignment list --assignee "jdoe@contoso.com"

# Remove a role assignment
az role assignment delete   --assignee "jdoe@contoso.com"   --role "Contributor"   --resource-group "Sales-RG"

# List all role definitions
az role definition list

# Check user's permissions on a resource
az role assignment list   --assignee "jdoe@contoso.com"   --scope "/subscriptions/<sub-id>/resourceGroups/Sales-RG"
