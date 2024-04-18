import { application } from "controllers/application"
import RailsNestedForm from '@stimulus-components/rails-nested-form'

import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

application.register('nested-form', RailsNestedForm)