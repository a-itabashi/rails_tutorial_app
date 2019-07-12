Rails.application.routes.draw do
  get 'users/new'
  root to: 'staticpages#home'
  get  '/help',    to: 'staticpages#help'
  get  '/about',   to: 'staticpages#about'
  get  '/contact', to: 'staticpages#contact'
end
