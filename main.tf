provider "google" {
  project     = "sa-mlops-dev"
  #region      = "eu-west4"
  #zone        = "us-central1-c"
}

resource "google_service_account" "service_account" {
  account_id   = "vertex-pipelines-sa"
  display_name = "vertex-pipelines-sa"
  description = "sa to run pipelines"
  #project = "sa-mlops-dev"
}


#resource "google_project_iam_binding" "project" {
#  project = "sa-mlops-dev"
#  role    = "roles/aiplatform.user"

#  members = [
#    "serviceAccount:vertex-pipelines-sa@sa-mlops-dev.iam.gserviceaccount.com",
#  ]
#}

#resource "google_project_iam_binding" "project" {
#  project = "sa-mlops-dev"
#  role    = "roles/storage.objectAdmin"

#  members = [
#    "serviceAccount:vertex-pipelines-sa@sa-mlops-dev.iam.gserviceaccount.com",
#  ]
#}

resource "google_project_iam_binding" "project" {
  project = "sa-mlops-dev"
  members = [
    "serviceAccount:vertex-pipelines-sa@sa-mlops-dev.iam.gserviceaccount.com",
  ]
  for_each = toset([ 
     "roles/iap.tunnelResourceAccessor", 
     "roles/compute.osLogin",
     "roles/bigquery.jobUser",
     "roles/bigquery.dataEditor",
     "roles/storage.objectViewer",
     "roles/storage.objectCreator",
     "roles/aiplatform.user",
     #"roles/iam.serviceAccountUser"
   ])
   role   = each.key
   
}