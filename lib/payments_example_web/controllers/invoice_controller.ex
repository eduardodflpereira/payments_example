defmodule PaymentsExampleWeb.InvoiceController do
  use PaymentsExampleWeb, :controller

  alias PaymentsExample.Billing
  alias PaymentsExample.Billing.Invoice
  alias PaymentsExample.Billing.Service.CreateCheckout

  def index(conn, _params) do
    invoices = Billing.list_invoices()
    render(conn, "index.html", invoices: invoices)
  end

  def new(conn, _params) do
    changeset = Billing.change_invoice(%Invoice{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"invoice" => invoice_params}) do
    case Billing.create_invoice(invoice_params) do
      {:ok, invoice} ->
        conn
        |> put_flash(:info, "Invoice created successfully.")
        |> redirect(to: Routes.invoice_path(conn, :show, invoice))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    invoice = Billing.get_invoice!(id)
    render(conn, "show.html", invoice: invoice)
  end

  def edit(conn, %{"id" => id}) do
    invoice = Billing.get_invoice!(id)
    changeset = Billing.change_invoice(invoice)
    render(conn, "edit.html", invoice: invoice, changeset: changeset)
  end

  def update(conn, %{"id" => id, "invoice" => invoice_params}) do
    invoice = Billing.get_invoice!(id)

    case Billing.update_invoice(invoice, invoice_params) do
      {:ok, invoice} ->
        conn
        |> put_flash(:info, "Invoice updated successfully.")
        |> redirect(to: Routes.invoice_path(conn, :show, invoice))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", invoice: invoice, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    invoice = Billing.get_invoice!(id)
    {:ok, _invoice} = Billing.delete_invoice(invoice)

    conn
    |> put_flash(:info, "Invoice deleted successfully.")
    |> redirect(to: Routes.invoice_path(conn, :index))
  end

  def checkout(conn, %{"id" => id}) do
    invoice = Billing.get_invoice!(id)

    case CreateCheckout.call(invoice) do
      {:ok, %{url: payment_url} = _stripe_result} ->
        render(conn, "checkout.html", payment_url: payment_url)

      {:error, %Stripe.Error{} = _error} ->
        conn
        |> put_flash(:error, "Something went wrong.")
        |> redirect(to: Routes.invoice_path(conn, :show, invoice))
    end
  end

  def stripe_success(conn, _params) do
    render(conn, "success.html")
  end

  def stripe_cancel(conn, _params) do
    render(conn, "cancel.html")
  end
end
