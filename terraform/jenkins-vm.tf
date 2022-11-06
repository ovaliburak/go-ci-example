terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("./.cred/key.json")

  project = "go-devops-app"
  region  = "us-central1"
  zone    = "us-central1-a"
}

resource "google_compute_instance" "default" {
  boot_disk {
    auto_delete = true
    device_name = "jenkins-boot"

    initialize_params {
      image = "https://www.googleapis.com/compute/beta/projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20221018"
      size  = 20
      type  = "pd-standard"
    }

  }

  # confidential_instance_config {
  #   enable_confidential_compute = false
  # }

  labels = {
    app = "jenkins"
  }

  machine_type = "e2-medium"
  name         = "jenkins-vm-2"

  network_interface {
    access_config {
      # nat_ip       = "35.209.243.47"
      network_tier = "STANDARD"
    }

    network            = "https://www.googleapis.com/compute/v1/projects/go-devops-app/global/networks/default"
    # network_ip         = "10.128.0.4"
    # stack_type         = "IPV4_ONLY"
    subnetwork         = "https://www.googleapis.com/compute/v1/projects/go-devops-app/regions/us-central1/subnetworks/default"
    subnetwork_project = "go-devops-app"
  }

  project = "go-devops-app"

  # reservation_affinity {
  #   type = "ANY_RESERVATION"
  # }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    # provisioning_model  = "STANDARD"
  }

  metadata_startup_script = "${file("./scripts/jenkins.sh")}"

  service_account {
    email  = "956503270234-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_vtpm                 = true
  }

  tags = ["http-server", "https-server"]

}
# terraform import google_compute_instance.jenkins_vm projects/go-devops-app/zones/us-central1-a/instances/jenkins-vm
