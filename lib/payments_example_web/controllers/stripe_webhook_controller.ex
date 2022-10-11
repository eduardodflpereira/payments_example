defmodule PaymentsExampleWeb.StripeWebhookController do
    @moduledoc """
  Actions for all endpoints that related Stripe Webhooks
  """
  use PaymentsExampleWeb, :controller

  alias PaymentsExample.Billing

  def webhook(%Plug.Conn{assigns: %{stripe_event: stripe_event}} = conn, _params) do
    case handle_event(stripe_event) do
      {:ok, _} -> handle_success(conn)
      {:error, error} -> handle_error(conn, error)
      _ -> handle_error(conn, "error")
    end
  end

  defp handle_success(conn) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "ok")
  end

  defp handle_error(conn, error) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(422, error)
  end

  def handle_event(%{type: "checkout.session.completed", data: %{object: stripe_object}}) do
    with %Stripe.Session{metadata: %{"invoice_id" => invoice_id}} <- stripe_object,
         invoice <- Billing.get_invoice!(invoice_id) do
      Billing.update_invoice(invoice, %{status: "paid"})
    end

    {:ok, "success"}
  end

  def handle_event(%{data: %{object: stripe_object}}) do
    with %Stripe.Session{metadata: %{"invoice_id" => invoice_id}} <- stripe_object,
         invoice <- Billing.get_invoice!(invoice_id) do
      Billing.update_invoice(invoice, %{status: "payment failed"})
    end

    {:error, "Payment Failed"}
  end
end
