module FormHelper

  def cancel_button(path)
    link_to 'Cancel', path,
      class: 'btn btn-default'
  end

  def save_button
    content_tag :button, type: 'submit', class: 'btn btn-primary' do
      'BackUp'
    end
  end

end
