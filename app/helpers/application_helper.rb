module ApplicationHelper
  def dibs_referral_body
    product_info = @order.line_items.map {|item| [item.variant.product.name, "Price: " + "%.2f" % item.price, "Qty: " + item.quantity.to_s].join("\n")}
    product_info << "Total: #{@order.display_total}"
    "http://#{Spree::Config[:site_url]}/dibs_referral?dibs_referral=#{URI::encode_www_form_component @current_user.email}&#{@order.dibs_referral_line_items.to_param}\n\n#{product_info.join("\n\n" + "-"*5 + "\n\n")}"
  end
end
