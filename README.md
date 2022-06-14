# Waypoint Go Deployed to Kubernetes Example

| Title    | Description                                                                          |
| -------- | ------------------------------------------------------------------------------------ |
| Pack     | Cloud Native Buildpack                                                               |
| Cloud    | Local                                                                                |
| Language | Go                                                                                   |
| Docs     | [Kubernetes](https://www.waypointproject.io/plugins/kubernetes)                      |
| Tutorial | [HashiCorp Learn](https://learn.hashicorp.com/tutorials/waypoint/get-started-docker) |

A barebones Go API, which can easily be deployed by Waypoint.

This example assumes you will be deploying the application onto Kubernetes.
It also uses a remote container registry jFrog. Unless you are me, you'll need
to change the image value to point at your own registry. And be sure to setup
your local Kubernetes cluster to have credentials to pull the image.

### Note

This example project application is mostly intended for me to use while developing
Waypoint features. Some of the config options might not be valid for a released
version of Waypoint and won't work yet.
