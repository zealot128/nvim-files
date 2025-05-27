return {
  {
    "tpope/vim-rails",
    ft = { "ruby", "slim", "haml", "eruby" },
    cmd = { "Einitializer", "Econtroller", "Emodel" },
    init = function()
      vim.api.nvim_exec([[command! Rroutes Einitializer]], true)
      vim.api.nvim_exec([[command! Eroutes Einitializer]], true)

      -- " let g:rails_abbreviations=0
      -- " let g:rails_no_abbreviations=1
      vim.g.rails_projections = {
        ["config/projections.json"] = {
          ["command"] = "projections",
        },

        -- from a packs/* back into main app
        ["../../app/models/*.rb"] = {
          ["command"] = "gmodel",
        },

        ["app/services/*.rb"] = {
          ["command"] = "service",
          ["affinity"] = "model",
          ["test"] = "spec/services/%s_spec.rb",
          ["related"] = "app/models/%s.rb",
          ["template"] = "class %S\n\n  def run\n  end\nend",
        },
        ["app/graphql/types/*_type.rb"] = {
          ["command"] = "gtype",
          ["affinity"] = "model",
          ["rubyAction"] = { "field", "argument" },
          ["related"] = "app/models/%s.rb",
          ["template"] = {
            "class Types::{camelcase|capitalize|colons}Type < Types::BaseObject",
            "  field :id, ID, null: false",
            "end",
          },
        },
        ["app/graphql/mutations/*.rb"] = {
          ["command"] = "gmutation",
          ["related"] = "app/models/%s.rb",
          ["rubyAction"] = { "argument", "field" },
          ["template"] = {
            "class Mutations::{camelcase|capitalize|colors} < Mutations::BaseMutation",
            "  argument :input, Types::{camelcase|capitalize|colons}Type, required: true",
            "  field :errors, [::Types::ValidationErrorsType], null: false",
            "",
            "  def resolve(input:)",
            "  end",
            "end",
          }
        },
        ["app/jobs/*_job.rb"] = {
          ["affinity"] = "model",
          ["template"] = {
            "class {camelcase|capitalize|colons}Job < ApplicationJob",
            "  queue_as :default",
            "",
            "  def perform",
            "  end",
            "end"
          },
          ["type"] = "job"
        },
        ["app/jobs/cronjob/*_job.rb"] = {
          ["template"] = {
            "class Cronjob::{camelcase|capitalize|colons}Job < Cronjob",
            "  cronjob cron: \"everay day at 1am\"",
            "",
            "  def perform",
            "  end",
            "end"
          },
          ["type"] = "cronjob"
        },
        ["app/components/*.rb"] = {
          ["command"] = "component",
          ["test"] = "spec/components/%s.rb",
          ["alternate"] = "app/components/%s.slim",
          ["rubyAction"] = { "renders_many", "renders_one", "with_content_areas", "with_collection_parameter" },
          ["rubyHelper"] = { "helpers" },
          ["template"] = {
            "class {camelcase|capitalize|colons} < ViewComponent::Base",
            "  def initialize(current_user:)",
            "    @current_user = current_user",
            "  end",
            "end",
          },
        },
        ["app/serializers/*_serializer.rb"] = {
          ["command"] = "serializer",
          ["affinity"] = "model",
          ["test"] = "spec/serializers/%s_spec.rb",
          ["related"] = "app/models/%s.rb",
          ["template"] = "class %S < ActiveModel::Serializer\n\n  embed ids:, include= true\n\n  attribute :id\nend",
        },
        ["app/admin/*.rb"] = {
          ["command"] = "admin",
          ["affinity"] = "model",
          ["related"] = "app/models/%s.rb",
          ["template"] = "ActiveAdmin.register %S do\n\n  # form do |f|\n   # f.inputs do\n   # end\n   # f.actions\n  # end\n\n  #menu parent= '', label= ''\n\n  # index do\n  #default_actions\n  # end\n\nend\n",
        },
        ["app/javascript/*.vue"] = {
          ["command"] = "vue",
          ["template"] = "<template lang='pug'>\n  div\n</template>\n<script>\n\nexport default {\n  computed= {}\n};\n</script>\n<style lang='scss'>\n</style>",
        },
        ["config/locales/*de.yml"] = { ["alternate"] = "%sen.yml" },
        ["config/locales/*en.yml"] = { ["alternate"] = "%sde.yml" },
        ["config/*.rb"] = {
          ["command"] = "config",
        },
        ["api/api/*.rb"] = {
          ["command"] = "api",
        },
        ["spec/support/*.rb"] = {
          ["command"] = "support",
        },
        ["spec/features/*_spec.rb"] = {
          ["command"] = "feature",
          ["template"] = "require 'spec_helper'\n\nfeature '%h' do\n\nend",
        },
      }
      require "plugins.vim-rails"
    end,
  },
   {
    "moguls753/rails-i18n-hover.nvim",
    config = function()
      require("rails-i18n-hover").setup({
        goto_lang     = "de",
        goto_file_keymap = "<leader>gt"
      })
    end,
    ft = { "ruby", "slim", "haml", "eruby" },
    dependencies = {
      "nvim-neotest/nvim-nio",
    },
  },
}
