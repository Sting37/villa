<?php

class BookingDetailHandler extends BookingDetailDAO
{
    public function __construct()
    {
    }

    private $executionFeedback;

    public function getExecutionFeedback()
    {
        return $this->executionFeedback;
    }

    public function setExecutionFeedback($executionFeedback)
    {
        $this->executionFeedback = $executionFeedback;
    }

    public function getAllBookings()
    {
        $bookings = $this->fetchBooking();

        if (is_array($bookings)) {
            return $bookings;
        } else {
            $this->setExecutionFeedback(Util::DB_SERVER_ERROR);
            return []; // prevent foreach errors
        }
    }

    public function getCustomerBookings(Customer $c)
    {
        $bookings = $this->fetchBookingByCid($c->getId());

        if (is_array($bookings)) {
            $this->setExecutionFeedback(1);
            return $bookings;
        }

        $this->setExecutionFeedback(0);
        return [];
    }

    public function getPending()
    {
        $count = 0;
        $pending = \models\StatusEnum::PENDING_STR;
        foreach ($this->getAllBookings() as $v) {
            if (($v["status"] == $pending) || (strtoupper($v["status"]) == $pending)) {
                $count++;
            }
        }
        return $count;
    }

    public function getConfirmed()
    {
        $count = 0;
        $confirmed = \models\StatusEnum::CONFIRMED_STR;
        foreach ($this->getAllBookings() as $v) {
            if (($v["status"] == $confirmed) || (strtoupper($v["status"]) == $confirmed)) {
                $count++;
            }
        }
        return $count;
    }

    public function confirmSelection($item)
    {
        for ($i = 0; $i < count($item); $i++) {
            if (is_numeric($item[$i])) {
                if ($this->updateConfirmed($item[$i])) {
                    $out = "These reservations have been successfully <b>confirmed</b>.";
                    $out .= " This page will reload to reflect changes.";
                    $this->setExecutionFeedback($out);
                } else {
                    $this->setExecutionFeedback("There must be an error processing your request. Please try again later.");
                }
            } else {
                $this->setExecutionFeedback("Something is not right!");
            }
        }
    }

    public function cancelSelection($item)
    {
        for ($i = 0; $i < count($item); $i++) {
            if (is_numeric($item[$i])) {
                if ($this->updateCancelled($item[$i])) {
                    $out = "These reservations have been successfully <b>cancelled</b>.";
                    $out .= " This page will reload to reflect changes.";
                    $this->setExecutionFeedback($out);
                } else {
                    $this->setExecutionFeedback("There must be an error processing your request. Please try again later.");
                }
            } else {
                $this->setExecutionFeedback("Something is not right!");
            }
        }
    }
}

// todo: protect booking functionalities (only admin can perform)
