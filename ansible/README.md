# Ansible

## k3d role
- `force_recreate` controls cluster recreation.
- Config changes require `force_recreate=true` to take effect.

Example:
```
ansible-playbook -i ansible/inventory/hosts ansible/playbooks/site.yml -e force_recreate=true
```

## Local overrides
- Put host-specific values in `ansible/vars/local.yml` (git-ignored).
- Load it with:
```
ansible-playbook -i ansible/inventory/hosts ansible/playbooks/site.yml -e @ansible/vars/local.yml
```

## Host vars
- Inventory host aliases live in `ansible/inventory/hosts`.
- Host-specific connection details go in `ansible/inventory/host_vars/<host>.yml` (git-ignored).
- Example:
```
ansible/inventory/host_vars/macmini.yml
```

Example runs:
```
ansible-playbook -i ansible/inventory/hosts ansible/playbooks/site.yml -e @ansible/vars/local.yml
ansible-playbook -i ansible/inventory/hosts ansible/playbooks/site.yml -e @ansible/vars/local.yml -e force_recreate=true
```
