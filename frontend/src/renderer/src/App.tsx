import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom'
import { Toaster } from '@/components/ui/sonner'
import { LayoutProvider } from '@/context/layout-provider'
import { ProtectedRoute, PublicRoute } from '@/components/protected-route'
import { SignIn, SignUp } from '@/features/auth'
import { AdminApp } from '@/admin'

import { ClientApp } from '@/client'
import SearchPage from '@renderer/client/search/components/SearchPage'
import BookingDetailPage from '@renderer/client/bookingDetails/components/BookingDetailPage'

import Navbar from '@renderer/components/Navbar'
import Footer from '@renderer/components/Footer'

function AppRouter(): React.JSX.Element {
  return (
    <Routes>
      {/* Public Routes - Auth Pages */}
      <Route
        path="/sign-in"
        element={
          <PublicRoute>
            <SignIn />
          </PublicRoute>
        }
      />
      <Route
        path="/sign-up"
        element={
          <PublicRoute>
            <SignUp />
          </PublicRoute>
        }
      />

      {/* Protected Admin Routes */}
      <Route
        path="/admin/*"
        element={
          <ProtectedRoute allowedRoles={['SUPERADMIN', 'ADMIN', 'MANAGER', 'RECEPTIONIST']}>
            <AdminApp />
          </ProtectedRoute>
        }
      />

      <Route
        path="/"
        element={
          <PublicRoute>
            <ClientApp />
          </PublicRoute>
        }
      />

      <Route
        path="/search"
        element={
          <PublicRoute>
            <SearchPage />
          </PublicRoute>
        }
      />

      <Route
        path="/bookingdetail"
        element={
          <PublicRoute>
            <BookingDetailPage />
          </PublicRoute>
        }
      />

      {/* Default redirect */}
      {/* <Route path="/" element={<Navigate to="/sign-in" replace />} /> */}

      {/* Catch all - redirect to client */}
      <Route path="*" element={<Navigate to="/" replace />} />
    </Routes>
  )
}

function App(): React.JSX.Element {
  return (
    <BrowserRouter>
      <LayoutProvider>
        <Navbar />
        <div className="w-full flex flex-col pt-14">
          <AppRouter />
          <Toaster position="top-right" richColors closeButton />
        </div>
        <Footer />
      </LayoutProvider>
    </BrowserRouter>
  )
}

export default App
