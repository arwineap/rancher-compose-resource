# rancher-compose resource

This is a rancher-compose resource which teaches concourse how to trigger deployments in rancher.

## resource configuration
```
resource_types:
- name: rancher-compose
  type: docker-image
  source:
    repository: arwineap/rancher-compose-resource
```

## Source configuration
* `url`: Required. The URL of the rancher endpoint
* `access_key`: Required. A Rancher access_key for the project's environment
* `secret_key`: Required. A Rancher secret_key for the project's environment

*Example*
```
resources:
- name: rancher
  type: rancher-compose
  source:
    url: http://rancher.foo.com
    access_key: ((rancher_access_key))
    secret_key: ((rancher_secret_key))
```

## Behavior
### check
noop

### in
noop

### out
Deploys a rancher project.

*parameters*
* `path` Required. path to docker-compose and rancher-compose files
* `project` Required. The name of the rancher-compose project
* `service` Optional. Name of the service to affect. If not specified all services are affected.
* `pull` Optional. If set, the project image is always pulled before a deployment
* `upgrade` Optional. One of (true|false|confirm|rollback). Starts, forces, confirms, or rolls back an upgrade

## Example

```
jobs:
- name: blog
  plan:
  - get: blogRepo
    trigger: true
  - put: blogImage
    params:
      build: blogRepo
  - put: compose
    params:
      path: blogRepo
      project: app
      service: blog
      pull: true
      upgrade: force
  - put: compose
    params:
      path: blogRepo
      service: blog
      upgrade: confirm
```


## credits
This was heavily based on the nodejs version of this here: https://github.com/ndarilek/concourse-rancher-compose-resource

