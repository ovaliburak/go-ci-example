curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3

chmod 700 get_helm.sh

./get_helm.sh
helm uninstallation

    which helm ( to see which folder its installed )
    rm -rf /usr/local/bin/helm
