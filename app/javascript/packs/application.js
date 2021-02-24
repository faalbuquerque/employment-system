require("bootstrap")

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'bootstrap-icons/font/bootstrap-icons.css'

Rails.start()
Turbolinks.start()
ActiveStorage.start()
