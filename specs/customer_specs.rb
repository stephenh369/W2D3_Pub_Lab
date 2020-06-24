require("minitest/autorun")
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative("../customer")
require_relative("../drink")
require_relative("../pub")


class CustomerTest < MiniTest::Test

    def setup()
        @pub = Pub.new("Shandwicks", [@drink1, @drink2, @drink3])
        @customer = Customer.new("Stephen", 20.00, 25)
        @customer2 = Customer.new("James", 500.00, 15)
        @drink1 = Drink.new("Carling", 1.75)
        @drink2 = Drink.new("Hop House 13", 2.00)
        @drink3 = Drink.new("Smirnoff", 1.50)    
    end

    def test_get_name()
        assert_equal("Stephen", @customer.name())
    end

    def test_get_wallet()
        assert_equal(20.00, @customer.wallet())
    end
        
    def test_get_age()
        assert_equal(25, @customer.age())
    end

    def test_remove_cash()
        @customer.remove_cash(1.50)
        assert_equal(18.50, @customer.wallet())
    end
    
    def test_buy_drink_from_pub__pass()
        @customer.buy_drink_from_pub(@drink3, @customer, @pub)
        assert_equal(18.50, @customer.wallet())
        assert_equal(151.50, @pub.till())
        assert_equal(true, @pub.is_of_age(@customer))
    end

    def test_buy_drink_from_pub__fail()
        @customer2.buy_drink_from_pub(@drink3, @customer2, @pub)
        assert_equal(500.00, @customer2.wallet())
        assert_equal(150.00, @pub.till())
        assert_equal(false, @pub.is_of_age(@customer2))
    end

end

    # def test_reduce_wallet()
    #     assert_equal(18.00, @customer.reduce_wallet("Hop House 13"))
    # end

