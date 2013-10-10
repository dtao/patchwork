module ImplementationHelper
  def implementation_link(implementation)
    [
      link_to(implementation.patch.name, implementation.patch),
      link_to(implementation.user.name, implementation.user)
    ].join('/').html_safe
  end
end
