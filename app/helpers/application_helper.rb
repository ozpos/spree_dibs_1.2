module ApplicationHelper
  def dibs_referral_body
    product_info = [["Product", "Qty", "Price"]]
    product_info.concat @order.line_items.map {|item| [item.variant.product.name, {value: item.quantity.to_s, align: :right}, {value: "%.2f" % item.price, align: :right}]}
    "http://#{Spree::Config[:site_url]}/dibs_referral?dibs_referral=#{URI::encode_www_form_component @current_user.email}&#{@order.dibs_referral_line_items.to_param}\n\n#{product_info.to_table(first_row_is_head: true)}"
  end
end
