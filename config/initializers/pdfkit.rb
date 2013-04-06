PDFKit.configure do |config|       
  config.wkhtmltopdf = Rails.root.join('bin', 'wkhtmltopdf-amd64').to_s if Rails.env.production?  
end

def request_from_pdfkit?
  # when generating a PDF, PDFKit::Middleware will set this flag
  request.env["Rack-Middleware-PDFKit"] == "true"
end