SimpleCov.start do
  add_filter %w[spec config bin vendor]

  add_group 'Decorators', 'app/decorators'
  add_group 'Facades',    'app/facades'
  add_group 'Forms',      'app/forms'
  add_group 'Operations', 'app/operations'
  add_group 'Jobs',       'app/jobs'
  add_group 'Models',     'app/models'
  add_group 'Policies',   'app/policies'
  add_group 'Queries',    'app/queries'
  add_group 'Services',   'app/services'
end
