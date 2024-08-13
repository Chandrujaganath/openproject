# frozen_string_literal: true

# -- copyright
# OpenProject is an open source project management software.
# Copyright (C) the OpenProject GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See COPYRIGHT and LICENSE files for more details.
# ++

module WorkPackages
  module Exports
    module PDF
      class ExportSettingsComponent < BaseExportSettingsComponent
        def current_pdf_export_type
          "table"
        end

        def gantt_chart_allowed?
          EnterpriseToken.allows_to?(:gantt_pdf_export)
        end

        def pdf_export_types
          [
            { value: "table",
              label: I18n.t("export.dialog.pdf.export_type.options.table.label"),
              caption: I18n.t("export.dialog.pdf.export_type.options.table.caption"),
              component: WorkPackages::Exports::PDF::Table::ExportSettingsComponent },
            { value: "report",
              label: I18n.t("export.dialog.pdf.export_type.options.report.label"),
              caption: I18n.t("export.dialog.pdf.export_type.options.report.caption"),
              component: WorkPackages::Exports::PDF::Report::ExportSettingsComponent },
            { value: "gantt",
              label: I18n.t("export.dialog.pdf.export_type.options.gantt.label"),
              caption: I18n.t("export.dialog.pdf.export_type.options.gantt.caption"),
              disabled: !gantt_chart_allowed?,
              component: WorkPackages::Exports::PDF::Gantt::ExportSettingsComponent }
          ]
        end
      end
    end
  end
end
